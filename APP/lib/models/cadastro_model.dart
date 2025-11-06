class RegisterRequest {
  final String nome;
  final String cpf;
  final String email;
  final String password;
  final String role;
  final String bairro;
  final int numeroend;    // alterado para int
  final String uf;
  final String complemento;
  final String cep;
  final String logradouro;
  final String telefone;

  RegisterRequest({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.password,
    required this.role,
    required this.bairro,
    required this.numeroend,   // int aqui também
    required this.uf,
    required this.complemento,
    required this.cep,
    required this.logradouro,
    required this.telefone,
  });

  Map<String, dynamic> toJson() => {
        'nome': nome.trim(),
        'cpf': cpf.replaceAll(RegExp(r'\D'), ''), // remove máscara
        'email': email.trim(),
        'password': password,
        'role': role,
        'bairro': bairro,
        'numeroend': numeroend,    // enviado como número
        'uf': uf,
        'complemento': complemento,
        'cep': cep,
        'logradouro': logradouro,
        'telefone': telefone,
      };
}
