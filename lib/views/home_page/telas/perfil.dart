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
    int xpNivel = 300;
    return Container(
      color: AppColors.secondary,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 200,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                      child: CircleAvatar(),
                      width: double.infinity,
                    ),
                    flex: 3),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text('${userInfo.user.name}',
                            style: TextStyles.blackHintText),
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
                  value: xpAtual / xpNivel,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  '$xpAtual/$xpNivel XP',
                  style: TextStyles.blackHintText,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Card(
                    child: Container(
                      color: AppColors.secondaryDark,
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
