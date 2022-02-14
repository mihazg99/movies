import 'dart:io';

import 'package:eventgreen/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddMovieProvider extends ChangeNotifier{
  final ImagePicker _picker = ImagePicker();
  final ApiManager _api = ApiManager();

  String? _title;
  int? _publishingYear;
  XFile? _file;
  bool _isImageSet = false;
  File? _image;

  get title => _title;
  get publishingYear => _publishingYear;
  get file => _file;
  get isImageSet => _isImageSet;
  get image => _image;

  void changeTitle(title){
    _title = title;
  }

  void changeYear(year){
    _publishingYear = year;
  }

  Future<void> pickImageFromGallery() async{
    // Pick an image
    _file = await _picker.pickImage(source: ImageSource.gallery);

    _image = File(_file!.path);
    _isImageSet = true;
    notifyListeners();
  }

  void uploadMovie(){
    _api.addMovie(_title,_publishingYear, _image);
  }

  void reset(){
    _isImageSet = false;
  }

}