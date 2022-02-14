import 'package:eventgreen/models/login_model.dart';
import 'package:eventgreen/providers/add_movie_provider.dart';
import 'package:eventgreen/util/style/text_styles.dart';
import 'providers/movie_provider.dart';
import 'package:eventgreen/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => LoginModel()),
        ChangeNotifierProvider<MovieProvider>(create: (context) =>MovieProvider()),
        ChangeNotifierProvider<AddMovieProvider>(create: (context) =>AddMovieProvider())
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
      title: 'Movies',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(hintStyle: CustomTextStyles.SMALL),
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}
