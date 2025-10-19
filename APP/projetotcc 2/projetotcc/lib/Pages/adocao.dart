import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/animal.dart';
import '../providers/animal_provider.dart';
import '../providers/login_provider.dart';
import 'interesse_adocao.dart';

class AdocaoPage extends StatelessWidget {
  const AdocaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final animalProvider = Provider.of<AnimalProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Pets para Adoção")),
      body: RefreshIndicator(
        onRefresh: () async => animalProvider.carregarAnimais(),
        child: animalProvider.carregando
            ? const Center(child: CircularProgressIndicator())
            : animalProvider.erro != null
                ? Center(child: Text('Erro: ${animalProvider.erro}'))
                : ListView.builder(
                    itemCount: animalProvider.animais.length,
                    itemBuilder: (context, index) {
                      final animal = animalProvider.animais[index];
                      return Card(
                        child: ListTile(
                          leading: animal.imagemUrl != null
                              ? Image.network(animal.imagemUrl!)
                              : const Icon(Icons.pets),
                          title: Text(animal.nome),
                          subtitle: Text(
                              "${animal.especie}, ${animal.idade} anos"),
                          trailing: ElevatedButton(
                            onPressed: loginProvider.estaLogado
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => InteresseAdocaoPage(
                                          nomeAnimal: animal.nome,
                                          idade: animal.idade.toString(),
                                          raca: animal.especie,
                                          imagemPath:
                                              animal.imagemUrl ?? '',
                                        ),
                                      ),
                                    );
                                  }
                                : null, // botão desativado se não logado
                            child: const Text('Adotar'),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
