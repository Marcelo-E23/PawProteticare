import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cadastro_model.dart';
import '../models/login_model.dart';
import '../models/authentication_model.dart';
import '../models/usuario_model.dart';
import '../utils/api.utils.dart';

class ApiService {// Troque pela sua URL

  Future<AuthenticationResponse> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/usuario/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthenticationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao registrar usuário: ${response.body}');
    }
  }

  Future<AuthenticationResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/authenticate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final authResponse = AuthenticationResponse.fromJson(jsonDecode(response.body));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', authResponse.accessToken);
      await prefs.setString('refreshToken', authResponse.refreshToken);
      return authResponse;
    } else {
      throw Exception('Falha no login: ${response.body}');
    }
  }

  Future<Usuario> getUserData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/usuario/$email'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao buscar dados do usuário: ${response.body}');
    }
  }
}
