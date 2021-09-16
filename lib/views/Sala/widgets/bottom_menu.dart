import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: AppColors.secondary,
      child: TabBar(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: AppColors.primary),
            insets: EdgeInsets.symmetric(horizontal: 16.0)),
        indicatorColor: AppColors.primary,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Container(
              height: size.height * 0.1,
              child: Center(
                  child: Text('Tarefas', style: TextStyles.primaryHintText))),
          Container(
              height: size.height * 0.1,
              child: Center(
                  child: Text('Sala', style: TextStyles.primaryHintText))),
          Container(
              height: size.height * 0.1,
              child: Center(
                  child: Text('Tarefas enviadas',
                      style: TextStyles.primaryHintText))),
          Container(
              height: size.height * 0.1,
              child: Center(
                  child: Text('Corrigir tarefas',
                      style: TextStyles.primaryHintText))),
          Container(
              height: size.height * 0.1,
              child: Center(
                  child:
                      Text('Scoreboard', style: TextStyles.primaryHintText))),
        ],
      ),
    );
  }
}
