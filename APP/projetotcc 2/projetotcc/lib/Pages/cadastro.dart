import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';
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
  bool _isLoading = false;

  bool camposValidos() {
    return (_formKey.currentState?.validate() ?? false) &&
        _senhaController.text == _confirmarSenhaController.text;
  }

  void _cadastrar() async {
    if (!camposValidos()) return;

    setState(() => _isLoading = true);
    final provider = Provider.of<LoginProvider>(context, listen: false);
    final sucesso = await provider.cadastrar(
      _nomeController.text.trim(),
      _emailController.text.trim(),
      _senhaController.text,
    );
    setState(() => _isLoading = false);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(sucesso ? 'Sucesso!' : 'Erro'),
        content: Text(sucesso
            ? 'Cadastro realizado com sucesso!'
            : 'Falha ao cadastrar. Verifique seus dados.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (sucesso) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              }
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                const Text('Cadastro', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome completo'),
                  validator: (value) => value != null && value.trim().contains(' ') ? null : 'Digite nome e sobrenome',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: (value) => value != null && value.contains('@') ? null : 'E-mail inválido',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  obscureText: !_senhaVisivel,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(_senhaVisivel ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                    ),
                  ),
                  validator: (value) => value != null && value.length >= 6 ? null : 'Senha deve ter 6+ caracteres',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmarSenhaController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirmar senha'),
                  validator: (value) => value == _senhaController.text ? null : 'Senhas não coincidem',
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _cadastrar,
                        child: const Text('Cadastrar'),
                      ),
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
