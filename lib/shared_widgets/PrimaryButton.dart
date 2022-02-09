import 'package:eventgreen/util/style/color_scheme.dart';
import 'package:eventgreen/util/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(this.buttonText, this.onPressed, this.width);

  final String buttonText;
  final void Function() onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
            color: CustomColorScheme.PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(10)),
        width: width,
        height: 54,
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.montserrat(textStyle: CustomTextStyles.REGULAR),
          ),
        ),
      ),
    );
  }
}
