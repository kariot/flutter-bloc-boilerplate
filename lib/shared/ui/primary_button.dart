import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Widget? trailingIcon;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: roundedButtonStyle,
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
          : Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
    );
  }
}

final roundedButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100), // <-- Radius
    ),
    backgroundColor: Colors.orange);
