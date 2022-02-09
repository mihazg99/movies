import 'package:eventgreen/models/LoginModel.dart';
import 'package:eventgreen/models/movie_provider.dart';
import 'package:eventgreen/screens/login/login.dart';
import 'package:eventgreen/screens/movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => LoginModel()),
        ProxyProvider<LoginModel, MovieProvider>(
            update: (context, loginModel, movieModel) =>
                MovieProvider(loginModel)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
