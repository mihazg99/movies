import 'package:eventgreen/models/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  @override
  void initState() {
    // TODO: implement initState
    var provider = Provider.of<MovieProvider>(context, listen: false);
    provider.getAllMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Container(
      child: Column(children: [
        Row(children: [

        ],),
        buildListView(context)
      ],),
    );
  }

  Widget buildListView(context){
    return Consumer<MovieProvider>(builder: (context,provider,child){
      return Text("test");
    });
  }
}

