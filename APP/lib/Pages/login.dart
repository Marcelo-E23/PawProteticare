import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetotcc/Pages/cadastro.dart';
import '../services/api_service.dart';
import '../models/login_model.dart';
import '../models/authentication_model.dart';
import 'tela_inicial.dart'; // Troque pelo seu caminho correto

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isFormValid = false;

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _senhaController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final request = LoginRequest(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );

      AuthenticationResponse authResponse = await _apiService.login(request);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );

      // Navegação para a tela principal com fade transition
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => const FiebScreen(), // Troque pelo seu widget
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar login: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ✅ Cores adaptativas — modo claro e escuro
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB);
    final containerColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF0A2E5C);
    final textSecondary = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4B5563);
    final inputFill = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF9FAFB);
    final inputBorder = isDark ? const Color(0xFF3A3A3C) : const Color(0xFFD1D5DB);
    final iconColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final placeholderColor = isDark ? const Color(0xFF6B6B6B) : const Color(0xFF9CA3AF);
    final buttonColor = _isFormValid
        ? (isDark ? const Color(0xFF0A84FF) : const Color(0xFF0A2E5C))
        : (isDark ? const Color(0xFF3A3A3C) : const Color(0xFF9CA3AF));
    final linkColor = isDark ? const Color(0xFF6EA8FF) : const Color(0xFF0A2E5C);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.4)
                              : Colors.black.withOpacity(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // LOGO
                          Center(
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo1.png',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // TÍTULO
                          Text(
                            "Paw Proteticare",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),

                          // SUBTÍTULO
                          Text(
                            "Acesse sua conta para continuar ajudando nossos peludinhos.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: textSecondary,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 28),

                          // EMAIL
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: [AutofillHints.email],
                            onChanged: (_) => _validateForm(),
                            style: TextStyle(color: textPrimary, fontSize: 16),
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              prefixIcon: Icon(Icons.email_outlined, color: iconColor),
                              suffixIcon: _emailController.text.isNotEmpty
                                  ? Icon(
                                      _emailController.text.contains('@')
                                          ? Icons.check_circle
                                          : Icons.error,
                                      color: _emailController.text.contains('@')
                                          ? Colors.green
                                          : Colors.redAccent,
                                      size: 20,
                                    )
                                  : null,
                              filled: true,
                              fillColor: inputFill,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: inputBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: linkColor, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.redAccent),
                              ),
                              hintText: "seu@email.com",
                              hintStyle: TextStyle(color: placeholderColor),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return '⚠️ Digite seu e-mail';
                              }
                              if (!value.contains('@')) {
                                return '⚠️ E-mail inválido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // SENHA (sem ícone de validação!)
                          TextFormField(
                            controller: _senhaController,
                            obscureText: _obscurePassword,
                            autofillHints: [AutofillHints.password],
                            onChanged: (_) => _validateForm(),
                            style: TextStyle(color: textPrimary, fontSize: 16),
                            decoration: InputDecoration(
                              labelText: "Senha",
                              prefixIcon: Icon(Icons.lock_outline, color: iconColor),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: iconColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: inputFill,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: inputBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: linkColor, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.redAccent),
                              ),
                              hintText: "Mínimo 8 caracteres",
                              hintStyle: TextStyle(color: placeholderColor),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return '⚠️ Digite sua senha';
                              }
                              if (value.length < 8) {
                                return '⚠️ Mínimo de 8 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),

                          // "Esqueci minha senha?" (desabilitado)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: null, // TODO: implementar depois
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                foregroundColor: linkColor.withOpacity(0.8),
                              ),
                              child: Text(
                                "Esqueceu sua senha?",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // BOTÃO COM LOADING
                          SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: _isLoading ? null : _submit,
                              icon: _isLoading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.arrow_forward, size: 18),
                              label: Text(
                                _isLoading ? "Entrando..." : "Entrar",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // LINK DE CADASTRO
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Não tem conta? ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: textSecondary,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Cadastre-se",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: linkColor,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => const Cadastro(),
                                            transitionDuration: const Duration(milliseconds: 300),
                                            transitionsBuilder:
                                                (context, animation, secondaryAnimation, child) {
                                              return FadeTransition(opacity: animation, child: child);
                                            },
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}