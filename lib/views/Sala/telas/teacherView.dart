import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/models/sala_model.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:ludic/shared/widgets/fancyFab.dart';

class TeacherView extends StatelessWidget {
  const TeacherView({
    Key? key,
    required this.sala,
  }) : super(key: key);

  final Sala sala;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0))),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: size.height * 0.1),
                        itemCount: sala.alunos.length,
                        itemBuilder: (_, index) {
                          return Text('alo');
                        }),
                  ));
        },
      ),
      body: DefaultTabController(
        length: 2,
        child: ListView(
          children: [
            Text('Professor', style: TextStyles.blackTitleText),
            ListTile(
              title: Text(sala.professor),
            ),
            Text('Alunos', style: TextStyles.blackTitleText),
            ListView.builder(
              itemCount: sala.alunos.length,
              itemBuilder: (_, index) {
                return Text(sala.alunos[index]['name']);
              },
              shrinkWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
