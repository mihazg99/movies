import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager{
  final dio = Dio();

  Future<String?> loginWithUsernameAndPassword() async{
    final prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var password = prefs.getString('password');
    var jwt;

    try{
      ///add form data
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

  Future<bool> addMovie(title,year,file) async{
    this.loginWithUsernameAndPassword().then((token) async{
      if(token != null){

        try{
          ///authorization token
          dio.options.headers["Authorization"] = "Bearer $token";
          dio.options.contentType = 'application/json';

          ///add form data
          var formData = FormData.fromMap({
            'data': {"name": "$title", "publicationYear": year},
            'files.poster': await MultipartFile.fromFile(file.path,
          filename: "test"),
          });

          ///upload new movie to database
          var response = await dio.post('https://zm-movies-assignment.herokuapp.com/api/movies', data: formData);

          return true;

        }catch(error){
          print(error);

          return false;
        }

      }

    }).catchError((onError){
      print(onError);
    });

    return false;
  }
}