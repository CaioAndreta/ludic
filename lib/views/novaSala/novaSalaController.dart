import 'package:ludic/views/novaSala/telas/1_nomeSala.dart';
import 'package:ludic/views/novaSala/telas/2_addTarefas.dart';
import 'package:ludic/views/novaSala/telas/3_codigoSala.dart';

class NovaSalaController {
  var currentPage = 0;
  void setPage(int index) {
    currentPage = index;
  }
}
