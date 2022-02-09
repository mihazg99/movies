import 'package:image_picker/image_picker.dart';

class Movie{
  Movie(this.title, this.year, this.poster);

  String? title;
  int? year;
  String? poster;

  Movie.fromMap(Map<String, dynamic> map){
    title = map['title'];
    year = map['year'];
    poster = map['poster'];
  }

}