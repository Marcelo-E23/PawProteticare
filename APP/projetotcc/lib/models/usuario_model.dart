class UsuarioModel {
  final String nome;
  final String cpf;
  final String? email;
  final String? password;
  final String? bairro;
  final int? numeroend;
  final String? uf;
  final String? complemento;
  final String? cep;
  final String? logradouro;
  final String? telefone;
  final bool? codStatus;

  UsuarioModel({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.password,
    this.bairro,
    this.numeroend,
    this.uf,
    this.complemento,
    this.cep,
    this.logradouro,
    this.telefone,
    this.codStatus,
  });
  // Converte para JSON, removendo campos nulos
  Map<String, dynamic> toJson() {
    final data = {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'password': password,
      'bairro': bairro,
      'numeroend': numeroend,
      'uf': uf,
      'complemento': complemento,
      'cep': cep,
      'logradouro': logradouro,
      'telefone': telefone,
      'codStatus': codStatus,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }

  // Cria objeto a partir de JSON
  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      password: json['password'],
      bairro: json['bairro'],
      numeroend: json['numeroend'],
      uf: json['uf'],
      complemento: json['complemento'],
      cep: json['cep'],
      logradouro: json['logradouro'],
      telefone: json['telefone'],
      codStatus: json['codStatus'],
    );
  }
}
