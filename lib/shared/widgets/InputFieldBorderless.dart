import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

// ignore: must_be_immutable
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
    return Column(
      children: [
        Container(
            width: size.width * 0.7,
            alignment: Alignment.centerLeft,
            child: Text(widget.label, style: TextStyles.primaryHintText)),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            height: 70,
            width: size.width * 0.8,
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              obscureText: widget.obscureText,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary))),
            )),
      ],
    );
  }
}
