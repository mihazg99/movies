import 'package:eventgreen/models/movie_provider.dart';
import 'package:eventgreen/shared_widgets/movie_card.dart';
import 'package:flutter/cupertino.dart';
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
      child: Column(
        children: [
          Row(
            children: [],
          ),
          buildListView(context)
        ],
      ),
    );
  }

  Widget buildListView(context) {
    return Consumer<MovieProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        provider.getAllMovies();

        return Text("Loading");
      } else {
        return Container(
          height: 400,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: provider.movies.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieCard(provider.movies[index]);
              }),
        );
      }
    });
  }
}
