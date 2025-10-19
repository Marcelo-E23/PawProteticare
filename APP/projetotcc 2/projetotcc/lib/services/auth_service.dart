import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_constants.dart';

class AuthService {
  /// Login retorna token
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

  /// Cadastro retorna token
  Future<String?> cadastrar(String nome, String email, String senha) async {
    final response = await http.post(
      Uri.parse(ApiConstants.cadastro),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['token'];
    }
    return null;
  }

  /// Validar token JWT
  Future<bool> validarToken(String token) async {
    final response = await http.get(
      Uri.parse(ApiConstants.validarToken),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response.statusCode == 200;
  }
}
