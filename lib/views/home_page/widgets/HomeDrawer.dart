import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/auth/auth_controller.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  final UserModel userInfo;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      '${userInfo.name}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: AppColors.secondary, fontSize: 25),
                    ),
                  ),
                  Text(
                    'displayName',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.secondary, fontSize: 15),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
          ),
          Container(
            color: AppColors.secondary,
            child: Column(
              children: [
                Container(
                  color: AppColors.secondary,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Sair'),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.remove('email');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
