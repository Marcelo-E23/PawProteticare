class UsuarioModel {
  final int? id;
  final String? nome;
  final String? cpf;

  UsuarioModel({this.id, this.nome, this.cpf});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json['id'],
        nome: json['nome'],
        cpf: json['cpf'],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'nome': nome ?? '',
        'cpf': cpf ?? '',
      };
}
