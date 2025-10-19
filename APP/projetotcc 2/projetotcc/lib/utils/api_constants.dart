class ApiConstants {
  static const String baseUrl = 'http://localhost:8080';

  // Endpoints de autenticação
  static const String login = '$baseUrl/login';
  static const String cadastro = '$baseUrl/cadastro';
  static const String validarToken = '$baseUrl/validar-token';

  // Endpoints de animais
  static const String animachado = '$baseUrl/animachado';
  static const String proteses = '$baseUrl/proteses';

  // Endpoints de doações
  static const String doacoes = '$baseUrl/doacoes';
}
