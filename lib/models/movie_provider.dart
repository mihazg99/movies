import 'package:dio/dio.dart';
import 'package:eventgreen/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'movie.dart';
import 'movie_model.dart';

class MovieProvider extends ChangeNotifier{
  final ApiManager _api = ApiManager();

  List<Movie>? _movies = [];
  bool _isLoading = true;

  List<Movie> get movies => _movies!;
  bool get isLoading => _isLoading;

  ///get all movies and store it in [_movies]
  Future<bool> getAllMovies() async{
    print("get all movies");
    _api.loginWithUsernameAndPassword("mihael.ivicic99@gmail.com","=HE\$yWsLrC}2%-S@").then((token) async {

      if(token != null){
        print("token: $token");

        try{
          Response response;
          var dio = Dio();

          ///authorization token
          print("bearer $token");
          dio.options.headers["Authorization"] = "Bearer $token";

          response = await dio.get('https://zm-movies-assignment.herokuapp.com/api/movies?populate=*');
          var data = movieModelFromJson(response.toString());

          ///iterate trough data and store each movie sequence to list
          data.data!.forEach((element) {
            var year = element.attributes!.publicationYear;
            var name = element.attributes!.name;
            var url = element.attributes!.poster!.data!.attributes!.url;

            Movie movie = new Movie(name, year, url);
            _movies!.add(movie);
          });

          _isLoading = false;
          notifyListeners();

        }catch(error){
          print(error);

          return false;
        }

      }

    });

    return true;
  }
}