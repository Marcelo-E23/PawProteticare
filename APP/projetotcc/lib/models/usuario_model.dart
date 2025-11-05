class UsuarioModel {
  final String nome;
  final String cpf;

  UsuarioModel({required this.nome, required this.cpf});

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'cpf': cpf,
      };

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        nome: json['nome'],
        cpf: json['cpf'],
      );
}
