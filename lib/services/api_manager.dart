import 'package:dio/dio.dart';

class ApiManager{

  Future<String?> loginWithUsernameAndPassword(username,password) async{
    var jwt;
    try{
      ///initialize dio and add form data
      var dio = Dio();
      var formData = FormData.fromMap({
        'identifier': username,
        'password': password,
      });

      ///obtain user auth token and store it in model
      var response = await dio.post('https://zm-movies-assignment.herokuapp.com/api/auth/local', data: formData);

      ///check if token has been obtained and store it
      if(response.statusCode == 200){
         jwt = response.data['jwt'];
      }

      return jwt;
    }catch(error){
      print(error);

      return jwt;
    }
  }
}