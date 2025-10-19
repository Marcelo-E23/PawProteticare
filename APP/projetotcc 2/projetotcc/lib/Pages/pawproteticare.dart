import 'package:flutter/material.dart';

class PawProticare extends StatefulWidget {
  const PawProticare({super.key});

  @override
  State<PawProticare> createState() => _PawProticareState();
}

class _PawProticareState extends State<PawProticare> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedAnimal; // Se nulo, mostra todos

  final Map<String, String> animalImages = {
    "Coruja":
        "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
    "Leão":
        "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg",
    "Tigre": "https://upload.wikimedia.org/wikipedia/commons/5/56/Tiger.50.jpg",
    "Panda":
        "https://upload.wikimedia.org/wikipedia/commons/0/0f/Grosser_Panda.JPG",
  };

  void _searchAnimal() {
    setState(() {
      String searchQuery = _controller.text.trim().toLowerCase();
      _selectedAnimal = animalImages.keys.firstWhere(
        (animal) => animal.toLowerCase() == searchQuery,
        orElse: () => "", // Retorna uma string vazia em vez de null
      );

      // Se a pesquisa não encontrar um animal, mantém todos visíveis
      if (_selectedAnimal!.isEmpty) {
        _selectedAnimal = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paw Proteticare"),
        centerTitle: true,
        backgroundColor: const Color(0xff08025a),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 28,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color.fromARGB(115, 7, 197, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: _controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pesquisar Animal',
                        filled: true,
                        fillColor: Colors.lightBlue[50],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _searchAnimal,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60.0, 60.0),
                      ),
                      child: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: _selectedAnimal == null
                      ? // Se não houver pesquisa, exibe todos os animais
                      animalImages.entries.map((entry) {
                          return Column(
                            children: [
                              Image.network(entry.value,
                                  width: 400, height: 400),
                              const SizedBox(height: 8),
                              Text(entry.key,
                                  style: const TextStyle(fontSize: 64)),
                              const SizedBox(height: 16),
                            ],
                          );
                        }).toList()
                      : // Se houver pesquisa, exibe apenas o animal pesquisado
                      [
                          Image.network(animalImages[_selectedAnimal!]!,
                              width: 400, height: 400),
                          const SizedBox(height: 8),
                          Text(_selectedAnimal!,
                              style: const TextStyle(fontSize: 64.00)),
                        ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
