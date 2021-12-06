import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

// ignore: must_be_immutable
class InputPassword extends StatefulWidget {
  String? label;

  TextEditingController? controller;
  bool obscureText;
  Widget? suffixIcon;
  IconData? icon;
  String? initialValue;
  var validator;
  InputPassword(
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
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isHidden = true;

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
        obscureText: isHidden,
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
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(isHidden ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.primary),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                }),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(29)),
        ),
      ),
    );
  }
}
