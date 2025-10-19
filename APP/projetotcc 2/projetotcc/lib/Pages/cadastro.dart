import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';
import 'fieb.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _isLoading = false;

  void _cadastrar() async {
    setState(() => _isLoading = true);
    final provider = Provider.of<LoginProvider>(context, listen: false);
    final nome = _nomeController.text.trim();
    final email = _emailController.text.trim();
    final senha = _senhaController.text;

    final sucesso = await provider.cadastrar(nome, email, senha);
    setState(() => _isLoading = false);

    if (sucesso) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FiebScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Falha ao cadastrar. Tente novamente'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _nomeController, decoration: const InputDecoration(labelText: 'Nome completo')),
            const SizedBox(height: 16),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-mail')),
            const SizedBox(height: 16),
            TextField(controller: _senhaController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha')),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _cadastrar,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
