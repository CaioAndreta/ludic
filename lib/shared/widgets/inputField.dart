import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  String? label;

  TextEditingController? controller;
  bool obscureText;
  Widget? suffixIcon;
  IconData? icon;
  String? initialValue;
  var validator;
  InputField(
      {Key? key,
      this.label,
      this.icon,
      this.suffixIcon,
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
      width: size.width * 0.8,
      child: TextFormField(
        initialValue: widget.initialValue,
        enableInteractiveSelection: true,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(
                color: AppColors.primary,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: AppColors.primary, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: AppColors.delete, width: 2)),
          contentPadding:
              EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          prefixIcon: Icon(widget.icon, color: AppColors.primary),
          labelText: widget.label,
          labelStyle: TextStyles.primaryHintText,
          suffixIcon: widget.suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(29)),
        ),
      ),
    );
  }
}
