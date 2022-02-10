import 'package:eventgreen/util/style/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/login_model.dart';

class LoginCheckbox extends StatefulWidget {

  @override
  _LoginCheckboxState createState() => _LoginCheckboxState();
}

class _LoginCheckboxState extends State<LoginCheckbox> {
  var isChecked;

  @override
  void initState() {
    // TODO: implement initState
    isChecked = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginModel>(context, listen: false);
    return Checkbox(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: BorderSide(color: Colors.white),
      checkColor: Colors.white,
      activeColor: CustomColorScheme.INPUT_COLOR,
      fillColor: null,
      value: isChecked ,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value;
        });
        provider.changeRemember(value);
      },
    );
  }
}
