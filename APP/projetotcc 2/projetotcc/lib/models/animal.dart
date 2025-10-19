class Animal {
  final int id;
  final String nome;       // nome do animal
  final String especie;    // espécie
  final String historia;   // história do animal
  final int idade;         // idade
  final String? imagemUrl; // imagem
  final bool possuiProtese; // se tem prótese (protese_id != null)

  Animal({
    required this.id,
    required this.nome,
    required this.especie,
    required this.historia,
    required this.idade,
    this.imagemUrl,
    required this.possuiProtese,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      nome: json['nome'],
      especie: json['especie'],
      historia: json['historia'],
      idade: json['idade'],
      imagemUrl: json['imagem'], // supondo URL/base64 da API
      possuiProtese: json['protese_id'] != null,
    );
  }
}
