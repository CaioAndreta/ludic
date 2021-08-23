import 'package:flutter/material.dart';
import 'package:ludic/shared/models/firebaseFile.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../tarefa_professor_view.dart';

class TarefaDetalhes extends StatelessWidget {
  const TarefaDetalhes({
    Key? key,
    required this.futureFiles,
    required this.widget,
  }) : super(key: key);

  final Future<List<FirebaseFile>> futureFiles;
  final TarefaProfessor widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          var files = snapshot.data!;
          return Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome da tarefa:',
                  style: TextStyles.blackHintText,
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(widget.tarefa.nome,
                        style: TextStyles.blackTitleText)),
                Text(
                  'Descrição da tarefa:',
                  style: TextStyles.blackHintText,
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(widget.tarefa.descricao,
                        style: TextStyles.blackTitleText)),
                Text(
                  'Arquivos:',
                  style: TextStyles.blackHintText,
                ),
                Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        return ListTile(
                          title: Text(file.name, style: TextStyles.cardTitle),
                          trailing: IconButton(
                            icon: Icon(Icons.download),
                            onPressed: () async {
                              Future openFile() async {
                                await launch(file.url);
                              }

                              await openFile();
                            },
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}
