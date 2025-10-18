import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecuperarSenhaPage extends StatefulWidget {
  @override
  _RecuperarSenhaPageState createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final TextEditingController _emailController = TextEditingController();
  String _mensagem = '';
  Color _mensagemColor = Colors.black;

  bool _validarEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

  void _enviarEmailRecuperacao() {
    final email = _emailController.text.trim();

    if (!_validarEmail(email)) {
      setState(() {
        _mensagem = 'E-mail inválido. Tente novamente.';
        _mensagemColor = Colors.red;
      });
      return;
    }

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _mensagem = 'E-mail enviado! Verifique sua caixa de entrada.';
        _mensagemColor = Colors.green;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com textura orgânica
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/textura_organica.jpg'), // Adicione sua imagem aqui
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline,
                        size: 48, color: Color(0xff0c2772)),
                    SizedBox(height: 16),
                    Text(
                      'Recuperar Senha',
                      style: GoogleFonts.quicksand(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[0xff0c2772],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Digite seu e-mail para receber o link de redefinição.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _enviarEmailRecuperacao,
                      icon: Icon(Icons.send_outlined),
                      label: Text('Enviar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0c2772),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(height: 12),
                    AnimatedOpacity(
                      opacity: _mensagem.isEmpty ? 0 : 1,
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        _mensagem,
                        style: TextStyle(
                            color: _mensagemColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 24),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Voltar para o login'),
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xff0c2772),
                        textStyle: GoogleFonts.quicksand(fontSize: 14),
                      ),
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
