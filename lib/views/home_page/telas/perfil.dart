import 'package:flutter/material.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/views/home_page/homePage.dart';

class Perfil extends StatelessWidget {
  const Perfil({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  final HomePage userInfo;

  @override
  Widget build(BuildContext context) {
    int xpAtual = 30;
    return Container(
      color: AppColors.dark,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 200,
            color: AppColors.dark,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                      // color: Colors.yellowAccent,
                      child: CircleAvatar(),
                      width: double.infinity,
                    ),
                    flex: 3),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      // color: Colors.red,
                      child: Center(
                        child: Text('${userInfo.user.name}',
                            style: TextStyles.secondaryTitleText),
                      )),
                  flex: 1,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.secondaryDark,
                  color: AppColors.primary,
                  minHeight: 10,
                  value: xpAtual / 100,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  '$xpAtual/100 XP',
                  style: TextStyles.secondaryHintText,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: AppColors.secondary,
                    height: double.infinity,
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: ListTile(
                        title: Text('Conquistas',
                            style: TextStyles.primaryHintText),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(10, (int index) {
                    return Card(
                      color: Colors.blue[index * 100],
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        child: Text("$index"),
                      ),
                    );
                  }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
