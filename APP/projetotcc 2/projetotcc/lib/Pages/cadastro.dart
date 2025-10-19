import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:projetotcc/provider/login_provider.dart';
import 'login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _senhaVisivel = false;
  bool _confirmarSenhaVisivel = false;

  bool? nomeValidoVisual;
  bool? emailValidoVisual;
  bool? senhaValidaVisual;
  bool? confirmarSenhaValida;

  void atualizarNomeVisual(String valor) {
    setState(() {
      nomeValidoVisual = valor.trim().isEmpty ? null : nomeValido(valor);
    });
  }

  void atualizarEmailVisual(String valor) {
    setState(() {
      emailValidoVisual = valor.trim().isEmpty ? null : emailValido(valor);
    });
  }

  void atualizarSenhaVisual(String valor) {
    setState(() {
      senhaValidaVisual = valor.trim().isEmpty ? null : senhaForte(valor);
      confirmarSenhaValida = valor == _confirmarSenhaController.text;
    });
  }

  void atualizarConfirmarSenhaVisual(String valor) {
    setState(() {
      confirmarSenhaValida =
          valor.trim().isEmpty ? null : valor == _senhaController.text;
    });
  }

  bool nomeValido(String nome) {
    final partes = nome.trim().split(' ');
    return partes.length >= 2 &&
        partes.every((parte) =>
            parte.isNotEmpty &&
            parte[0] == parte[0].toUpperCase() &&
            parte.substring(1) == parte.substring(1).toLowerCase());
  }

  bool emailValido(String value) {
    return value.contains('@');
  }

  bool senhaForte(String senha) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$');
    return regex.hasMatch(senha);
  }

  bool camposValidos() {
    return (_formKey.currentState?.validate() ?? false) &&
        nomeValidoVisual == true &&
        emailValidoVisual == true &&
        senhaValidaVisual == true &&
        confirmarSenhaValida == true;
  }

  void _cadastrar() {
    if (camposValidos()) {
      Provider.of<LoginProvider>(context, listen: false).cadastrar(
        _nomeController.text.trim(),
        _emailController.text.trim(),
        _senhaController.text,
      );

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF0B1426),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline,
                  color: Color(0xFF00C0BD), size: 48),
              const SizedBox(height: 16),
              const Text(
                'Cadastro concluído!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                '🎉 Bem-vinda, ${_nomeController.text.split(' ').first}! Agora você faz parte da Paw Protetecare 💙',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              },
              child: const Text('Ir para o login',
                  style: TextStyle(color: Color(0xFF00C0BD))),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1426),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Cadastre-se',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00C0BD),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cadastre-se para continuar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9ADCDD),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(
                'Nome completo',
                controller: _nomeController,
                hintText: 'Ex: João Silva',
                valido: nomeValidoVisual,
                mensagemFeedbackValido: 'Nome válido',
                mensagemFeedbackInvalido: _nomeController.text.isEmpty
                    ? 'Campo obrigatório'
                    : 'Use nome e sobrenome com iniciais maiúsculas',
                onChanged: atualizarNomeVisual,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'E-mail',
                controller: _emailController,
                hintText: 'Digite seu e-mail',
                valido: emailValidoVisual,
                mensagemFeedbackValido: 'Email válido',
                mensagemFeedbackInvalido: _emailController.text.isEmpty
                    ? 'Campo obrigatório'
                    : 'E-mail inválido',
                onChanged: atualizarEmailVisual,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Senha',
                controller: _senhaController,
                obscureText: !_senhaVisivel,
                hintText: 'Crie uma senha segura',
                valido: senhaValidaVisual,
                mensagemFeedbackValido: 'Senha forte',
                mensagemFeedbackInvalido: _senhaController.text.isEmpty
                    ? 'Campo obrigatório'
                    : 'Use letras maiúsculas, minúsculas, números e símbolos',
                onChanged: atualizarSenhaVisual,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      setState(() => _senhaVisivel = !_senhaVisivel),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Confirmar Senha',
                controller: _confirmarSenhaController,
                obscureText: !_confirmarSenhaVisivel,
                hintText: 'Repita a senha',
                valido: confirmarSenhaValida,
                mensagemFeedbackValido: 'Senhas coincidem',
                mensagemFeedbackInvalido: _confirmarSenhaController.text.isEmpty
                    ? 'Campo obrigatório'
                    : 'Senhas não coincidem',
                onChanged: atualizarConfirmarSenhaVisual,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmarSenhaVisivel
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () => setState(
                      () => _confirmarSenhaVisivel = !_confirmarSenhaVisivel),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ao criar sua conta, você concorda com a ',
                style: TextStyle(fontSize: 14, color: Color(0xFF9ADCDD)),
              ),
              GestureDetector(
                onTap: () {
                  // Abrir política de privacidade
                },
                child: const Text(
                  'política de privacidade',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF00C0BD),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: camposValidos() ? _cadastrar : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: camposValidos()
                      ? const Color(0xFF00C0BD) // Turquesa vibrante
                      : const Color(0xFF83A3A5), // Cinza-azulado
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: camposValidos() ? 4 : 0,
                  shadowColor: camposValidos()
                      ? Colors.black.withOpacity(0.2)
                      : Colors.transparent,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  semanticsLabel: 'Botão para cadastrar',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: camposValidos() ? _cadastrar : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: camposValidos()
                      ? const Color(0xFF00C0BD) // Turquesa vibrante
                      : const Color(0xFF83A3A5), // Cinza-azulado
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: camposValidos() ? 4 : 0,
                  shadowColor: camposValidos()
                      ? Colors.black.withOpacity(0.2)
                      : Colors.transparent,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  semanticsLabel: 'Botão para cadastrar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    bool obscureText = false,
    String? hintText,
    required bool? valido,
    required String mensagemFeedbackValido,
    required String mensagemFeedbackInvalido,
    required void Function(String)? onChanged,
    Widget? prefixIcon,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final bool campoVazio = controller.text.trim().isEmpty;
    final bool mostrarErro = valido == false || campoVazio;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Color(0xFF9ADCDD)),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF9ADCDD)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white, size: 16),
                child: prefixIcon ?? const SizedBox(),
              ),
            ),
            suffixIcon: suffixIcon ??
                (valido != null
                    ? Icon(
                        valido ? Icons.check_circle : Icons.cancel,
                        color: valido ? Colors.green : const Color(0xFFE53935),
                        size: 20,
                      )
                    : null),
            filled: true,
            fillColor: const Color(0xFF000000),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: mostrarErro
                    ? const Color(0xFFE53935)
                    : const Color(0xFFA2BEBD),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: mostrarErro
                    ? const Color(0xFFE53935)
                    : const Color(0xFF00C0BD),
                width: 2,
              ),
            ),
          ),
        ),
        if (valido != null || campoVazio)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              campoVazio
                  ? 'Campo obrigatório'
                  : (valido == true
                      ? mensagemFeedbackValido
                      : mensagemFeedbackInvalido),
              style: TextStyle(
                color: campoVazio
                    ? const Color(0xFF9ADCDD)
                    : (valido == true ? Colors.green : const Color(0xFFE53935)),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
