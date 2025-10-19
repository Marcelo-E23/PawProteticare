import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:projetotcc/providers/login_provider.dart';
import 'login.dart';

class RecuperarSenhaPage extends StatefulWidget {
  const RecuperarSenhaPage({super.key});

  @override
  _RecuperarSenhaPageState createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final TextEditingController _emailController = TextEditingController();
  String _mensagem = '';
  Color _mensagemColor = Colors.black;
  bool _isLoading = false;

  bool _validarEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

  Future<void> _enviarEmailRecuperacao() async {
    final email = _emailController.text.trim();

    if (!_validarEmail(email)) {
      setState(() {
        _mensagem = 'E-mail inválido. Tente novamente.';
        _mensagemColor = Colors.red;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _mensagem = '';
    });

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final sucesso = await loginProvider.recuperarSenha(email);

    setState(() {
      _isLoading = false;
      if (sucesso) {
        _mensagem = 'E-mail enviado! Verifique sua caixa de entrada.';
        _mensagemColor = Colors.green;
      } else {
        _mensagem = 'Erro ao enviar e-mail. Tente novamente.';
        _mensagemColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com textura orgânica
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/textura_organica.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline, size: 48, color: Color(0xff0c2772)),
                    const SizedBox(height: 16),
                    Text(
                      'Recuperar Senha',
                      style: GoogleFonts.quicksand(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0c2772),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Digite seu e-mail para receber o link de redefinição.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        filled: true,
                        fillColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _enviarEmailRecuperacao,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.send_outlined),
                      label: Text(_isLoading ? 'Enviando...' : 'Enviar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0c2772),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedOpacity(
                      opacity: _mensagem.isEmpty ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _mensagem,
                        style: TextStyle(color: _mensagemColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xff0c2772),
                        textStyle: GoogleFonts.quicksand(fontSize: 14),
                      ),
                      child: const Text('Voltar para o login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
