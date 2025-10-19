import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';
import 'fieb.dart';
import 'cadastro.dart';
import 'recuperacaosenha.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isPressed = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _usuarioController.addListener(_validateForm);
    _senhaController.addListener(_validateForm);
  }

  void _validateForm() {
    final email = _usuarioController.text.trim();
    final senha = _senhaController.text;
    final isValidEmail = email.contains('@');
    final isValidSenha = senha.length >= 6;
    setState(() => _isFormValid = isValidEmail && isValidSenha);
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo1.png',
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "Paw Proteticare",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? const Color(0xFF4C8DFF)
                        : const Color(0xFF1976D2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildTextFormField(
                "Usuário",
                controller: _usuarioController,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                "Senha",
                controller: _senhaController,
                obscureText: _obscurePassword,
                isPassword: true,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecuperarSenhaPage()),
                    );
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      isDark ? Colors.white10 : Colors.black12,
                    ),
                  ),
                  child: Text(
                    'Esqueceu a senha?',
                    style: GoogleFonts.poppins(
                      color:
                          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildLoginButton(loginProvider, isDark),
              const SizedBox(height: 32),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Cadastro()),
                    );
                  },
                  icon: const Icon(Icons.person_add_alt_1, size: 18),
                  label: Text(
                    'Não tem conta? Cadastre-se',
                    style: GoogleFonts.poppins(
                      color:
                          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginProvider loginProvider, bool isDark) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.arrow_forward, size: 18),
          label: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text("Login"),
          style: ElevatedButton.styleFrom(
            backgroundColor: _isFormValid
                ? (isDark
                    ? const Color(0xFF64B5F6)
                    : const Color(0xFF1976D2))
                : (isDark ? const Color(0xFF555555) : Colors.grey),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: !_isFormValid || _isLoading
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _isLoading = true);
                    final usuario = _usuarioController.text.trim();
                    final senha = _senhaController.text;

                    // 🔹 Faz login via API e pega token
                    final sucesso =
                        await loginProvider.autenticar(usuario, senha);

                    setState(() => _isLoading = false);

                    if (sucesso) {
                      final token = loginProvider.token;
                      print('Token JWT: $token');

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FiebScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.white),
                              SizedBox(width: 8),
                              Text('⚠️ Usuário ou senha inválidos'),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    String label, {
    bool obscureText = false,
    bool isPassword = false,
    TextEditingController? controller,
    IconData? icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final value = controller?.text ?? "";
    final isValid =
        label == "Usuário" ? value.contains('@') : value.length >= 6;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: (_) => _validateForm(),
      decoration: InputDecoration(
        prefixIcon: Icon(icon,
            color:
                isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2)),
        labelText: label == "Usuário" ? "Digite seu e-mail" : "Senha",
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : value.isEmpty
                ? null
                : Icon(
                    isValid ? Icons.check_circle : Icons.error,
                    color: isValid ? Colors.green : Colors.redAccent,
                  ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '⚠️ Preencha o campo ${label.toLowerCase()}';
        }
        if (label == "Usuário" && !value.contains('@')) {
          return '⚠️ Digite um e-mail válido';
        }
        if (label == "Senha" && value.length < 6) {
          return '⚠️ Senha deve ter pelo menos 6 caracteres';
        }
        return null;
      },
    );
  }
}
