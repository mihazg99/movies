import 'package:dio/dio.dart';
import 'LoginModel.dart';
import 'movie.dart';
import 'movie_model.dart';

class MovieProvider {
  MovieProvider(this._loginModel);

  LoginModel _loginModel;

  List<Movie>? _movies = [];
  bool _isLoading = true;

  List<Movie> get movies => _movies!;
  bool get isLoading => _isLoading;

  ///get all movies and store it in [_movies]
  Future<bool> getAllMovies() async{
    String? token;

    _loginModel.loginWithUsernameAndPassword().then((isTokenRefreshed) async {
      if(isTokenRefreshed){
        token = _loginModel.token;
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
            print(movie);
            _movies!.add(movie);
          });

          print(response.data.toString());
          print(data.data![0].attributes!.publicationYear.toString());
          print(_movies);

          _isLoading = false;

        }catch(error){
          print(error);

          return false;
        }

      }

    });
    //String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEsImlhdCI6MTY0NDM2ODYwMCwiZXhwIjoxNjQ2OTYwNjAwfQ.H3UKdwav-IVwbRczXJMWT8gzEO05gIVp_Hft0Wlx8WI";
    return true;
  }
}