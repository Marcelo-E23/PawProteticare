import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../services/animal_service.dart';

class AnimalProvider with ChangeNotifier {
  final AnimalService _service = AnimalService();
  List<Animal> _animais = [];
  bool _carregando = false;
  String? _erro;

  List<Animal> get animais => _animais;
  bool get carregando => _carregando;
  String? get erro => _erro;

  Future<void> carregarAnimais() async {
    _carregando = true;
    notifyListeners();
    try {
      _animais = await _service.buscarAnimais();
      _erro = null;
    } catch (e) {
      _erro = e.toString();
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
