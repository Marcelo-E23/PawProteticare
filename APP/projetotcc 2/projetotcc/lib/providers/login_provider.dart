import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _token;
  String? _nomeUsuario;
  bool _logado = false;

  String? get token => _token;
  bool get estaLogado => _logado;
  String? get nomeUsuario => _nomeUsuario;

  // Login
  Future<bool> login(String email, String senha) async {
    final token = await _authService.login(email, senha);
    if (token != null) {
      _token = token;
      _logado = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Cadastro
  Future<bool> cadastrar(String nome, String email, String senha) async {
    final sucesso = await _authService.cadastrar(nome, email, senha);
    if (sucesso) {
      _nomeUsuario = nome;
      notifyListeners();
    }
    return sucesso;
  }

  // Recuperação de senha
  Future<bool> recuperarSenha(String email) async {
    return await _authService.recuperarSenha(email);
  }

  // Validação do token
  Future<bool> validarToken() async {
    if (_token == null) return false;
    final valido = await _authService.validarToken(_token!);
    if (!valido) deslogar();
    return valido;
  }

  // Logout
  void deslogar() {
    _token = null;
    _logado = false;
    _nomeUsuario = null;
    notifyListeners();
  }

  // Exemplo de pegar animais da API
  Future<List<dynamic>> listarAnimais() async {
    if (_token == null) return [];
    return await _authService.listarAnimais(_token!);
  }
}
