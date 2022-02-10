import 'package:eventgreen/services/api_manager.dart';

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

  Future<bool> getTokenFromServer(username,password) async{

    try{
      await api.loginWithUsernameAndPassword(username, password).then((value){
        _token = value;
      });

      return true;
    }catch(error){
      print(error);

      return false;
    }

  }

}