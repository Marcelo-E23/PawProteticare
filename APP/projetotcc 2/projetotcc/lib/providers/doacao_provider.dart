import 'package:flutter/material.dart';
import '../models/doacao_model.dart';
import '../services/doacao_service.dart';

class DoacaoProvider with ChangeNotifier {
  final _service = DoacaoService();

  // Histórico apenas do usuário logado
  List<DoacaoModel> _historicoUsuario = [];

  List<DoacaoModel> get historicoUsuario => _historicoUsuario;

  // Criar nova doação
  Future<void> adicionarDoacao(DoacaoModel doacao, String token) async {
    final nova = await _service.criarDoacao(doacao, token);
    _historicoUsuario.add(nova);
    notifyListeners();
  }

  // Carregar histórico do usuário logado
  Future<void> carregarDoacoesUsuario(String token) async {
    _historicoUsuario = await _service.listarDoacoesUsuario(token);
    notifyListeners();
  }
}

