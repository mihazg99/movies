import 'package:dio/dio.dart';
import 'package:eventgreen/screens/login/login.dart';
import 'package:eventgreen/services/api_manager.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/movie_model.dart';

class MovieProvider extends ChangeNotifier {
  final ApiManager _api = ApiManager();

  List<Movie>? _movies = [];
  bool _isLoading = true;

  List<Movie> get movies => _movies!;
  bool get isLoading => _isLoading;

  ///get all movies and store it in [_movies]
  Future<bool> getAllMovies() async {
    print("get all movies");
    _api
        .loginWithUsernameAndPassword()
        .then((token) async {
      if (token != null) {

        try {
          Response response;
          var dio = Dio();

          ///authorization token
          print("bearer $token");
          dio.options.headers["Authorization"] = "Bearer $token";

          response = await dio.get(
              'https://zm-movies-assignment.herokuapp.com/api/movies?populate=*');
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
        } catch (error) {
          print(error);

          return false;
        }
      }
    });

    return true;
  }

  void logout(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
