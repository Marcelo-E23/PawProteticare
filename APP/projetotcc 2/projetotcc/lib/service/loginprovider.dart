// lib/services/auth_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'https:localhost:8080'; // 🔹 coloque sua URL base

  Future<String?> login(String email, String senha) async {
    final url = Uri.parse('$baseUrl/Usuario');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // supondo que a API retorna algo como: {"token": "eyJhbGci..."}
      final token = data['token'];
      return token;
    } else {
      print('Erro ao fazer login: ${response.body}');
      return null;
    }
  }
}
