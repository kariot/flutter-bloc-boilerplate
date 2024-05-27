import 'package:bloc_boilerplate/shared/local_storage/i_shared_pref.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ISharedPref)
class SharedPref extends ISharedPref {
  @override
  Future<String> getAccessToken() async {
    //TODO fetch from local pref and return
    return '';
  }
}
