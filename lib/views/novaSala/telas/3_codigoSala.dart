import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';
import 'package:short_uuids/short_uuids.dart';

class CodigoSalaView extends StatelessWidget {
  const CodigoSalaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final uuid = ShortUuid.init();
    String codigoSala = uuid.generate();
    return Center(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: size.height * 0.15),
            Container(
              width: size.width * 0.9,
              child: Text(
                  'Tudo pronto! \n\nAgora que a sala foi criada, compartilhe o seguinte código para os alunos obterem acesso',
                  style: TextStyles.whitetxtCodigoSala),
            ),
            Container(height: size.height * 0.05),
            GestureDetector(
              onTap: () {
                Clipboard.setData(new ClipboardData(text: codigoSala));
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Copiado para a Área de Transferência'),
                  ));
              },
              child: Container(
                  color: AppColors.background,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    codigoSala,
                    style: TextStyles.purpleCodigoSala,
                  )),
            ),
            Text('(Toque para copiar)')
          ],
        ),
      ),
    );
  }
}
