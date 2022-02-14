import 'package:eventgreen/models/login_model.dart';
import 'package:eventgreen/screens/login/checkbox.dart';
import 'package:eventgreen/shared_widgets/primary_button.dart';
import 'package:eventgreen/util/style/color_scheme.dart';
import 'package:eventgreen/util/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../movies/movies.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorScheme.BACKGROUND_COLOR,
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    var provider = Provider.of<LoginModel>(context, listen: false);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign In",
            style: GoogleFonts.montserrat(textStyle: CustomTextStyles.H2),
          ),
          SizedBox(
            height: 30,
          ),
          buildForm(context),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginCheckbox(),
              Text(
                "Remeber me",
                style: GoogleFonts.montserrat(
                  textStyle: CustomTextStyles.SMALL,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryButton("Login", () {
              provider.saveUsernameAndPassword();
              ///function above that is called on login button press
              provider
                  .api.loginWithUsernameAndPassword()
                  .then((isLogged) {
                    print("islogged $isLogged");
                if (isLogged == null) {
                  _showAlertDialog(context);
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => MoviesPage()));
                }
              });
            }, MediaQuery.of(context).size.width),
          )
        ],
      ),
    );
  }

  /// build form containing two texfields with appropriate labels. one for [username] and one for [password]
  Widget buildForm(context) {
    var provider = Provider.of<LoginModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 45,
            child: TextField(
              style: CustomTextStyles.SMALL,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Username",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: CustomTextStyles.SMALL,
                fillColor: CustomColorScheme.INPUT_COLOR,
                filled: true,
              ),
              onChanged: (text) {
                provider.changeUsername(text);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 45,
            child: TextField(
              style: CustomTextStyles.SMALL,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: CustomTextStyles.SMALL,
                fillColor: CustomColorScheme.INPUT_COLOR,
                filled: true,
              ),
              onChanged: (text) {
                provider.changePassword(text);
              },
            ),
          )
        ],
      ),
    );
  }

  ///show alert if user authentification failed
  Future<void> _showAlertDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Authentification failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Wrong username or password.',
                  style: GoogleFonts.montserrat(
                      textStyle: CustomTextStyles.DIALOG),
                ),
                Text('Please try again!',
                    style: GoogleFonts.montserrat(
                        textStyle: CustomTextStyles.DIALOG)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
