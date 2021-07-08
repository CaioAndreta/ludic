import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  InputDecoration? decoration;
  bool obscureText;
  TextEditingController? controller;
  var validator;
  void Function(String)? onChanged;
  InputField(
      {Key? key,
      this.decoration,
      this.obscureText = false,
      this.onChanged,
      this.controller,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(29),
          border: Border.all(color: AppColors.primary)),
      child: TextFormField(
        autofocus: true,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        cursorColor: AppColors.primary,
        decoration: decoration,
        onChanged: onChanged,
      ),
    );
  }
}
