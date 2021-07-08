import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class Button extends StatelessWidget {
  @override
  String label;
  void Function()? onPressed;
  Button({Key? key, this.label = '', this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(29),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            primary: AppColors.primary),
        child: Text(
          label,
          style: TextStyle(color: AppColors.shape),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
