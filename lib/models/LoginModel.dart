import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class LoginModel {
  String? _username;
  String? _password;
  String? _token;
  bool _remember = false;

  String get username => _username!;
  String get password => _password!;
  String get token => _token!;
  bool get remember => _remember;

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

  Future<bool> loginWithUsernameAndPassword() async{

    try{

      ///initialize dio and add form data
      var dio = Dio();
      var formData = FormData.fromMap({
        'identifier': "mihael.ivicic99@gmail.com",
        'password': "=HE\$yWsLrC}2%-S@",
      });

      ///obtain user auth token and store it in model
      var response = await dio.post('https://zm-movies-assignment.herokuapp.com/api/auth/local', data: formData);

      if(response.statusCode == 200){
        var jwt = response.data['jwt'];
        changeToken(jwt);
      }

      return true;
    }catch(error){
      print("wrong username or password");

      return false;
    }
  }
}