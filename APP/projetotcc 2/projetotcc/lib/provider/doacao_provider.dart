import 'package:flutter/material.dart';
import '../doacao_model.dart';

class DoacaoProvider with ChangeNotifier {
  final List<Doacao> _historico = [];

  List<Doacao> get historico => _historico;

  void adicionarDoacao(Doacao doacao) {
    _historico.add(doacao);
    notifyListeners();
  }
}
