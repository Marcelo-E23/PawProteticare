import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';

class RecuperarSenhaPage extends StatefulWidget {
  const RecuperarSenhaPage({super.key});

  @override
  State<RecuperarSenhaPage> createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String _mensagem = '';
  Color _mensagemColor = Colors.black;

  bool _validarEmail(String email) => email.contains('@');

  void _enviarEmail() async {
    final email = _emailController.text.trim();
    if (!_validarEmail(email)) {
      setState(() {
        _mensagem = 'E-mail inválido.';
        _mensagemColor = Colors.red;
      });
      return;
    }

    setState(() => _isLoading = true);
    final provider = Provider.of<LoginProvider>(context, listen: false);
    final sucesso = await provider.recuperarSenha(email);
    setState(() {
      _isLoading = false;
      _mensagem = sucesso ? 'E-mail enviado com sucesso!' : 'Falha ao enviar e-mail.';
      _mensagemColor = sucesso ? Colors.green : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.lock_outline, size: 64),
                const SizedBox(height: 16),
                const Text('Recuperar Senha', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _enviarEmail,
                        child: const Text('Enviar'),
                      ),
                const SizedBox(height: 16),
                if (_mensagem.isNotEmpty)
                  Text(_mensagem, style: TextStyle(color: _mensagemColor)),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar para login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
