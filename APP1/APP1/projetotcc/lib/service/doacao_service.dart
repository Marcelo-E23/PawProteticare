import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/doacao_model.dart';
import '../utils/api_constants.dart';

class DoacaoService {
  // Criar doação
  Future<DoacaoModel> criarDoacao(DoacaoModel doacao, String token) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/doacao'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(doacao.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao criar doação: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    return DoacaoModel.fromJson(data);
  }

  // Listar doações do usuário logado
  Future<List<DoacaoModel>> listarDoacoesUsuario(String token) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/doacao/usuario'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> lista = jsonDecode(response.body);
      return lista.map((e) => DoacaoModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
