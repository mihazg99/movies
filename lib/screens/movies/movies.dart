import '../../providers/movie_provider.dart';
import 'package:eventgreen/screens/add_movie/add_movie.dart';
import 'package:eventgreen/shared_widgets/movie_card.dart';
import 'package:eventgreen/util/style/color_scheme.dart';
import 'package:eventgreen/util/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: CustomColorScheme.BACKGROUND_COLOR,
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(backgroundColor: CustomColorScheme.PRIMARY_COLOR,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMoviePage()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildBody(context) {
    var provider = Provider.of<MovieProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My movies",
                style: GoogleFonts.montserrat(textStyle: CustomTextStyles.H3),
              ),
              InkWell(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () => provider.logout(context),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          buildGridView(context)
        ],
      ),
    );
  }

  Widget buildGridView(context) {
    return Consumer<MovieProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        provider.getAllMovies();

        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container(
          height: 450,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height )-0.02,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
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
