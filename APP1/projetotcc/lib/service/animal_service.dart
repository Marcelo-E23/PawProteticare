import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/animal_model.dart';
import '../utils/api_constants.dart';

class AnimalService {
  Future<List<AnimalModel>> fetchAnimais() async {
    final response = await http.get(Uri.parse(ApiConstants.listarAnimais));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => AnimalModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar animais: ${response.statusCode}');
    }
  }
}
