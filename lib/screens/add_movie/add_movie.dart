import 'package:dotted_border/dotted_border.dart';
import 'package:eventgreen/providers/add_movie_provider.dart';
import 'package:eventgreen/screens/movies/movies.dart';
import 'package:eventgreen/shared_widgets/primary_button.dart';
import 'package:eventgreen/shared_widgets/secondary_button.dart';
import 'package:eventgreen/util/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../util/style/color_scheme.dart';

class AddMoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorScheme.BACKGROUND_COLOR,
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    var provider = Provider.of<AddMovieProvider>(context, listen: false);
    var _width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Create a new movie",
              style: GoogleFonts.montserrat(textStyle: CustomTextStyles.H3),
            ),
            SizedBox(
              height: 45,
            ),
            buildForm(context),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondaryButton("Cancel", () {
                  provider.reset();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MoviesPage()),
                      (route) => false);
                }, _width / 2.5),
                PrimaryButton("Submit", () {
                  provider.uploadMovie();
                }, _width / 2.5),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildForm(context) {
    var provider = Provider.of<AddMovieProvider>(context, listen: false);

    return Column(
      children: [
        Container(
          height: 45,
          child: TextField(
            style: CustomTextStyles.SMALL,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Title",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintStyle: CustomTextStyles.SMALL,
              fillColor: CustomColorScheme.INPUT_COLOR,
              filled: true,
            ),
            onChanged: (text) {
              provider.changeTitle(text);
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 45,
          child: TextField(
            keyboardType: TextInputType.number,
            style: CustomTextStyles.SMALL,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Publishing year",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintStyle: CustomTextStyles.SMALL,
              fillColor: CustomColorScheme.INPUT_COLOR,
              filled: true,
            ),
            onChanged: (text) {
              if (text.length > 0) {
                provider.changeYear(int.parse(text));
              }
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        uploadImage(context)
      ],
    );
  }

  Widget uploadImage(context) {
    ///check if image is set. if image is set it returns container with
    ///image otherwise it returns container with text and icon
    return Consumer<AddMovieProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return provider.isImageSet
            ? InkWell(
                onTap: () => provider.pickImageFromGallery(),
                child: Container(
                  height: 372,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: FileImage(provider.image)),
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColorScheme.INPUT_COLOR),
                ),
              )
            : InkWell(
                onTap: () => provider.pickImageFromGallery(),
                child: DottedBorder(
                  color: Colors.white,
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [10, 5, 10, 5, 10, 5],
                  child: Container(
                    height: 372,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColorScheme.INPUT_COLOR),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "Upload an image here",
                            style: GoogleFonts.montserrat(
                                textStyle: CustomTextStyles.SMALL),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
