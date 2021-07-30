import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

// ignore: must_be_immutable
class CodigoSalaView extends StatelessWidget {
  String codigo;
  CodigoSalaView({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: size.height * 0.15),
          Container(
            width: size.width * 0.9,
            child: Text(
                'Tudo pronto! \n\nAgora que a sala foi criada, compartilhe o seguinte código para os alunos obterem acesso:',
                style: TextStyles.secondaryTxtCodigoSala),
          ),
          Container(height: size.height * 0.05),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: codigo));
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('Copiado para a Área de Transferência'),
                ));
            },
            child: Container(
                color: AppColors.secondary,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  codigo,
                  style: TextStyles.primaryCodigoSala,
                )),
          ),
          Text('(Toque para copiar)', style: TextStyles.secondaryHintText)
        ],
      ),
    );
  }
}
