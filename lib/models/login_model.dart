import 'package:eventgreen/services/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel {
  String? _username;
  String? _password;
  String? _token;
  bool _remember = false;

  String get username => _username!;
  String get password => _password!;
  String get token => _token!;
  bool get remember => _remember;

  final ApiManager api = ApiManager();

  void changePassword(pass){
    _password = pass;
  }

  void changeUsername(username){
    _username = username;
  }

  void changeToken(token){
    _token = token;
  }

  void changeRemember(remember){
    _remember = remember;
  }

  Future<void> saveUsernameAndPassword() async{
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', _username!);
    await prefs.setString('password', _password!);
  }

}