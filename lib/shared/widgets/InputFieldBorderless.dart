import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class InputFieldBorderless extends StatefulWidget {
  TextEditingController? controller;
  bool obscureText;
  String label;
  var validator;
  InputFieldBorderless(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.controller,
      this.validator})
      : super(key: key);

  @override
  _InputFieldBorderlessState createState() => _InputFieldBorderlessState();
}

class _InputFieldBorderlessState extends State<InputFieldBorderless> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 70,
        width: size.width * 0.8,
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.obscureText,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyles.purpleHintText,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary))),
        ));
  }
}
