import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/animal.dart';
import '../utils/api_constants.dart';

class AnimalService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<Animal>> buscarAnimais() async {
    final url = Uri.parse('$baseUrl/animachado?status=APTO_PARA_ADOCAO');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Animal.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar animais');
    }
  }
}
