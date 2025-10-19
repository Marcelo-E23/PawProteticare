import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _nome;
  String? _email;
  String? _token;
  bool _logado = false;

  bool get estaLogado => _logado;
  String? get token => _token;
  String? get nomeUsuario => _nome;
  String? get emailUsuario => _email;

  /// Login via API
  Future<bool> autenticar(String email, String senha) async {
    final token = await _authService.login(email, senha);
    if (token != null) {
      _email = email;
      _token = token;
      _logado = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Cadastro via API
  Future<bool> cadastrar(String nome, String email, String senha) async {
    final token = await _authService.cadastrar(nome, email, senha);
    if (token != null) {
      _nome = nome;
      _email = email;
      _token = token;
      _logado = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Desloga usuário
  void deslogar() {
    _nome = null;
    _email = null;
    _token = null;
    _logado = false;
    notifyListeners();
  }
}
