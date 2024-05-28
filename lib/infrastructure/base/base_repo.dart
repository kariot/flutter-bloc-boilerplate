import 'dart:convert';
import 'dart:io';

import 'package:bloc_boilerplate/di/injectable.dart';
import 'package:bloc_boilerplate/shared/local_storage/i_shared_pref.dart';
import 'package:bloc_boilerplate/shared/model/api_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/extensions/string.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

mixin BaseRepo {
  Client client = InterceptedClient.build(
    requestTimeout: const Duration(seconds: 40),
    interceptors: [],
  );

  Future<Either<ApiFailure, E>> post<E>(
    String url,
    Map<String, dynamic>? body,
    E Function(Map<String, dynamic>?) fromJsonE,
  ) async {
    return sendRequest<E>(
      url,
      body,
      fromJsonE,
      RequestType.POST,
    );
  }

  Future<Either<ApiFailure, E>> put<E>(
    String url,
    dynamic body,
    E Function(Object?) fromJsonE,
    Map<String, String> header,
    String Function(Map<String, dynamic>?) readAPIError,
  ) async {
    return sendRequest<E>(url, body, fromJsonE, RequestType.PUT);
  }

  Future<Either<ApiFailure, E>> patch<E>(
    String url,
    Map<String, dynamic>? body,
    E Function(Map<String, dynamic>?) fromJsonE,
    String Function(Map<String, dynamic>?) readAPIError,
  ) async {
    return sendRequest<E>(url, body, fromJsonE, RequestType.PATCH);
  }

  Future<Either<ApiFailure, E>> delete<E>(
    String url,
    E Function(Map<String, dynamic>?) fromJsonE,
    String Function(Map<String, dynamic>?) readAPIError,
  ) async {
    return sendRequest<E>(url, null, fromJsonE, RequestType.DELETE);
  }

  Future<Either<ApiFailure, E>> get<E>(
      String url,
      E Function(Map<String, dynamic>?) fromJsonE,
      String Function(Map<String, dynamic>?) readAPIError) async {
    debugPrint('Requesting to $url');
    return sendRequest<E>(url, null, fromJsonE, RequestType.GET);
  }

  Future<Map<String, String>> _getHeader() async {
    final token = await getIt<ISharedPref>().getAccessToken();
    Map<String, String> map = {'content-type': 'application/json'};
    if (token.isNotEmpty) {
      map['Authorization'] = 'Bearer $token';
    }
    return map;
  }

  Future<Either<ApiFailure, E>> sendRequest<E>(String url, dynamic body,
      E Function(Map<String, dynamic>?) fromJsonE, RequestType type,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('REQ -> $url');
      debugPrint('BODY -> ${jsonEncode(body.toString())}');
      var response = switch (type) {
        RequestType.GET => await client.get(Uri.parse(url)),
        RequestType.POST =>
          await client.post(Uri.parse(url), body: body, headers: headers),
        RequestType.PATCH =>
          await client.patch(Uri.parse(url), body: jsonEncode(body)),
        RequestType.PUT =>
          await client.put(Uri.parse(url), body: jsonEncode(body)),
        RequestType.DELETE => await client.delete(Uri.parse(url)),
      };
      debugPrint('RESP CODE : ${response.statusCode.toString()}');
      Map<String, dynamic>? decodedJson =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;

      debugPrint('RESP -> ${decodedJson?.toString()}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseObj = fromJsonE(decodedJson);
        return Right(responseObj);
      } else {
        if (response.statusCode == 422) {
          return Left(ApiFailure.serverError(
              message: decodedJson?['error'] ??
                  decodedJson?['message'] ??
                  'An unknown error occurred.!',
              errorCode: response.statusCode));
        } else {
          return Left(ApiFailure.serverError(
              message: decodedJson?['error'],
              errorCode: response.statusCode,
              validationMessage: getValidationMessage(decodedJson)));
        }
      }
    } catch (e) {
      debugPrint('<>e :${e.toString()}');
      if (e is SocketException) {
        return const Left(
            ApiFailure.clientError(message: 'Failed to connect to sever.'));
      }
      return const Left(
          ApiFailure.clientError(message: 'An unknown error occurred.!'));
    }
  }

  Future<Either<ApiFailure, E>> multiPartFileUpload<E>(
    String filePAth,
    String tag,
    String url,
    E Function(Object?) fromJsonE,
    String Function(Map<String, dynamic>?) readAPIError,
  ) async {
    try {
      var head = await _getHeader();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          url,
        ),
      )
        ..headers.addAll(head)
        ..files.add(await http.MultipartFile.fromPath(
          tag,
          filePAth,
        ));
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      debugPrint(response.statusCode.toString());
      Map<String, dynamic>? decodedJson =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;

      debugPrint('RESP -> ${decodedJson?.toString()}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseObj = fromJsonE(decodedJson);
        return Right(responseObj);
      } else {
        return Left(ApiFailure.serverError(message: readAPIError(decodedJson)));
      }
    } catch (e) {
      debugPrint('<>e :${e.toString()}');
      if (e is SocketException) {
        return const Left(
            ApiFailure.clientError(message: 'Failed to connect to sever.'));
      }
      return const Left(
          ApiFailure.clientError(message: 'An unknown error occured.!'));
    }
  }

  getValidationMessage(Map<String, dynamic>? decodedJson) {
    String validationMessage = '';

    try {
      Map<String, dynamic> errorMessages = decodedJson?['errors'];
      errorMessages.forEach((key, value) {
        for (String msg in value) {
          if (validationMessage.isEmpty) {
            validationMessage = msg;
          } else {
            validationMessage = '$validationMessage \n$msg';
          }
        }
      });
      return validationMessage;
    } catch (e) {
      return decodedJson?['message'];
    }
  }
}

enum RequestType { POST, PATCH, GET, PUT, DELETE }
