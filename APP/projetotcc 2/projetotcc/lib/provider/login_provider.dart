import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  String? _nomeCadastrado;
  String? _emailCadastrado;
  String? _senhaCadastrada;
  String? _avatarUrl; // ✅ Novo campo para o avatar
  bool _logado = false;

  /// Realiza o cadastro e retorna sucesso ou falha
  Future<bool> cadastrar(String nome, String email, String senha) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _nomeCadastrado = nome;
      _emailCadastrado = email;
      _senhaCadastrada = senha;
      _avatarUrl = null; // ou um caminho padrão se quiser
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Verifica se o login bate com os dados cadastrados
  bool autenticar(String email, String senha) {
    return email == _emailCadastrado && senha == _senhaCadastrada;
  }

  /// Marca o usuário como logado
  void logar() {
    _logado = true;
    notifyListeners();
  }

  /// Desloga o usuário
  void deslogar() {
    _logado = false;
    _avatarUrl = null;
    notifyListeners();
  }

  /// Atualiza o avatar do usuário
  void atualizarAvatar(String url) {
    _avatarUrl = url;
    notifyListeners();
  }

  /// Retorna se o usuário está logado
  bool get estaLogado => _logado;

  /// Retorna o nome do usuário cadastrado
  String? get nomeUsuario => _nomeCadastrado;

  /// Retorna o caminho da imagem do avatar
  String? get avatarUrl => _avatarUrl;

  get token => null;
}
