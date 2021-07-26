import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  InputDecoration? decoration;
  double height;
  TextEditingController? controller;
  bool obscureText;
  String? initialValue;
  var validator;
  InputField(
      {Key? key,
      this.decoration,
      required this.height,
      this.obscureText = false,
      this.controller,
      this.initialValue,
      this.validator})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: widget.height,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(29),
          border: Border.all(color: AppColors.primary)),
      child: TextFormField(
        initialValue: widget.initialValue,
        enableInteractiveSelection: true,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText,
        cursorColor: AppColors.primary,
        decoration: widget.decoration,
      ),
    );
  }
}
