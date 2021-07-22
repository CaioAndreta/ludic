import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:short_uuids/short_uuids.dart';

class CodigoSalaView extends StatelessWidget {
  const CodigoSalaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const uuid = ShortUuid();
    return Center(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: size.height * 0.15),
            Text(
                'Tudo pronto! Agora que a sala foi criada, compartilhe o seguinte código para os alunos obterem acesso'),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                child: Text(uuid.toString())),
            Expanded(child: Container()),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(29),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.95,
              child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      primary: AppColors.primary),
                  child: Text(
                    'Continuar',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
