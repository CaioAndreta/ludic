class TarefaAluno {
  String nomeAluno;
  String nomeTarefa;
  String? path;
  String email;
  String codigoSala;

  TarefaAluno(
      {required this.nomeAluno,
      this.path,
      required this.email,
      required this.codigoSala,
      required this.nomeTarefa});
}
