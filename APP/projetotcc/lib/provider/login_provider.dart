import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _token;
  String? _nomeUsuario;
  bool _logado = false;

  String? get token => _token;
  bool get estaLogado => _logado;
  String? get nomeUsuario => _nomeUsuario;

  // 🔹 Ao iniciar o app, carrega dados do armazenamento local
  Future<void> carregarLoginSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    final tokenSalvo = prefs.getString('token');
    final nomeSalvo = prefs.getString('nomeUsuario');

    if (tokenSalvo != null && nomeSalvo != null) {
      final valido = await _authService.validarToken(tokenSalvo);
      if (valido) {
        _token = tokenSalvo;
        _nomeUsuario = nomeSalvo;
        _logado = true;
        notifyListeners();
      } else {
        deslogar();
      }
    }
  }

  // 🔹 Login
  Future<bool> login(String email, String senha) async {
    final token = await _authService.login(email, senha);
    if (token != null) {
      _token = token;
      _logado = true;

      // Salva localmente
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Nome do usuário (opcional, depende do backend)
      _nomeUsuario = email.split('@').first;
      await prefs.setString('nomeUsuario', _nomeUsuario!);

      notifyListeners();
      return true;
    }
    return false;
  }

  // 🔹 Cadastro
  Future<bool> cadastrar(String nome, String email, String senha) async {
    final sucesso = await _authService.cadastrar(nome, email, senha);
    if (sucesso) {
      _nomeUsuario = nome;
      notifyListeners();
    }
    return sucesso;
  }

  // 🔹 Recuperar senha
  Future<bool> recuperarSenha(String email) async {
    return await _authService.recuperarSenha(email);
  }

  // 🔹 Validação do token
  Future<bool> validarToken() async {
    if (_token == null) return false;
    final valido = await _authService.validarToken(_token!);
    if (!valido) deslogar();
    return valido;
  }

  // 🔹 Logout (limpa local e memória)
  Future<void> deslogar() async {
    _token = null;
    _logado = false;
    _nomeUsuario = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('nomeUsuario');

    notifyListeners();
  }

  // 🔹 Exemplo de pegar animais da API
  Future<List<dynamic>> listarAnimais() async {
    if (_token == null) return [];
    return await _authService.listarAnimais(_token!);
  }
}
