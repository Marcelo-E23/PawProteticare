class AnimalModel {
  final int id;
  final String nome;
  final String especie;
  final String historia;
  final int idade;
  final String status;
  final String imagem; // URL da API ou caminho convertido

  AnimalModel({
    required this.id,
    required this.nome,
    required this.especie,
    required this.historia,
    required this.idade,
    required this.status,
    required this.imagem,
  });

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'],
      nome: json['nome'],
      especie: json['especie'],
      historia: json['historia'] ?? '',
      idade: json['idade'],
      status: json['status'],
      imagem: json['imagem'] ?? '', // Aqui você pode ajustar caso seja binário
    );
  }
}
