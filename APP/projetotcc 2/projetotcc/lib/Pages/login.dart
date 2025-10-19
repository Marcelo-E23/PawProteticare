import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';
import 'cadastro.dart';
import 'recuperar_senha.dart';
import 'inicio.dart'; // Tela principal após login

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) => value != null && value.contains('@') ? null : 'E-mail inválido',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: (value) => value != null && value.length >= 6 ? null : 'Senha deve ter 6+ caracteres',
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          final sucesso = await loginProvider.login(
                              _emailController.text.trim(), _senhaController.text);
                          setState(() => _isLoading = false);

                          if (sucesso) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => const TelaPrincipal()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login falhou.')),
                            );
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
              TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Cadastro())),
                  child: const Text('Cadastrar')),
              TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RecuperarSenhaPage())),
                  child: const Text('Esqueceu a senha?')),
            ],
          ),
        ),
      ),
    );
  }
}
