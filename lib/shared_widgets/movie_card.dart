import 'package:eventgreen/models/movie.dart';
import 'package:eventgreen/util/style/color_scheme.dart';
import 'package:eventgreen/util/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCard extends StatelessWidget {
  MovieCard(this._movie);

  final Movie _movie;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: CustomColorScheme.CARD_COLOR,
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Expanded(
            child: Image.network(_movie.poster!),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            _movie.title!,
            style: GoogleFonts.montserrat(textStyle: CustomTextStyles.REGULAR),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            _movie.year!.toString(),
            style: GoogleFonts.montserrat(textStyle: CustomTextStyles.SMALL),
          )
        ],
      ),
    );
  }
}
