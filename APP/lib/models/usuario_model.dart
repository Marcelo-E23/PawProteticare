class Usuario {
  String nome;
  String cpf;
  String email;
  String? telefone;
  String? bairro;
  String? logradouro;
  String? complemento;
  String? uf;
  String? cep;
  int? numeroend;
  String role;

  Usuario({
    required this.nome,
    required this.cpf,
    required this.email,
    this.telefone,
    this.bairro,
    this.logradouro,
    this.complemento,
    this.uf,
    this.cep,
    this.numeroend,
    required this.role,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      telefone: json['telefone'],
      bairro: json['bairro'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      uf: json['uf'],
      cep: json['cep'],
      numeroend: json['numeroend'],
      role: json['role'],
    );
  }
}
