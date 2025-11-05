import 'package:flutter/material.dart';
import '../models/animal_model.dart';
import '../service/animal_service.dart';

class AnimalProvider extends ChangeNotifier {
  final AnimalService _service = AnimalService();

  List<AnimalModel> _animais = [];
  bool _loading = false;

  List<AnimalModel> get animais => _animais;
  bool get loading => _loading;

  Future<void> carregarAnimais() async {
    _loading = true;
    notifyListeners();

    try {
      final todosAnimais = await _service.fetchAnimais();
      // 🔹 Filtra apenas os aptos para adoção
      _animais = todosAnimais
          .where((animal) => animal.status == 'APTO_PARA_ADOCAO')
          .toList();
    } catch (e) {
      _animais = [];
      debugPrint('Erro ao carregar animais: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
