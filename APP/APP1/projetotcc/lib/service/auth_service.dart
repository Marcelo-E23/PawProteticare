import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_constants.dart';

class AuthService {
  Future<String?> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'senha': senha}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    }
    return null;
  }

  Future<bool> cadastrar(String nome, String email, String senha) async {
    final response = await http.post(
      Uri.parse(ApiConstants.cadastrarUsuario),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
    );
    return response.statusCode == 201;
  }

  Future<bool> recuperarSenha(String email) async {
    final response = await http.post(
      Uri.parse(ApiConstants.recuperarSenha),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return response.statusCode == 200;
  }

  Future<bool> validarToken(String token) async {
    final response = await http.get(
      Uri.parse(ApiConstants.validarToken),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode == 200;
  }

  // Exemplo de método para listar animais da PawProtetecare
  Future<List<dynamic>> listarAnimais(String token) async {
    final response = await http.get(
      Uri.parse(ApiConstants.listarAnimais),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return [];
  }
}
