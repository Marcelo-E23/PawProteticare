import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetotcc/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:projetotcc/Pages/fieb.dart';
import 'package:projetotcc/Pages/cadastro.dart';
import 'package:flutter/gestures.dart'; // <-- IMPORT NECESSÁRIO

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _isButtonEnabled = false;

  late TapGestureRecognizer _tapRecognizer; // <-- CRIADO AQUI

  void _validateForm() {
    setState(() {
      _isButtonEnabled =
          _usuarioController.text.isNotEmpty && _senhaController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _usuarioController.addListener(_validateForm);
    _senhaController.addListener(_validateForm);

    // Inicializa o TapGestureRecognizer e define o comportamento do toque
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Cadastro(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      };
  }

  @override
  void dispose() {
    _tapRecognizer.dispose(); // <-- IMPORTANTE!
    _usuarioController.removeListener(_validateForm);
    _senhaController.removeListener(_validateForm);
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    Color corTexto = Colors.grey.shade800;
    Color corBotao = Colors.blueAccent;
    Color linkColor = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bem-vindo de volta!",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: corTexto,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Entre para continuar",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: "Usuário",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isButtonEnabled ? corBotao : Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isButtonEnabled
                      ? () async {
                          bool sucesso = await loginProvider.login(
                            _usuarioController.text,
                            _senhaController.text,
                          );
                          if (sucesso) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FiebScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuário ou senha incorretos.'),
                              ),
                            );
                          }
                        }
                      : null,
                  child: Text(
                    "Entrar",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: "Não tem uma conta? ",
                  style: GoogleFonts.poppins(fontSize: 14, color: corTexto),
                  children: [
                    TextSpan(
                      text: "Cadastre-se",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: linkColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: _tapRecognizer, // <-- USO CORRETO AQUI
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
