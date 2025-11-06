import 'package:flutter/material.dart'; 
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brasil_fields/brasil_fields.dart';
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
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmarpasswordController = TextEditingController();
  
  final Map<String, FocusNode> _focusNodes = {
    'nome completo': FocusNode(),
    'e-mail': FocusNode(),
    'cpf': FocusNode(),
    'password': FocusNode(),
    'confirmar password': FocusNode(),
  };
  
  bool _passwordVisivel = false;
  bool _confirmarpasswordVisivel = false;
  bool _aceitaPolitica = false;
  bool _enviando = false;

  bool? nomeValidoVisual;
  bool? emailValidoVisual;
  bool? cpfValidoVisual;
  bool? passwordValidaVisual;
  bool? confirmarpasswordValida;

  final Map<String, bool> _campoTocado = {
    'nome completo': false,
    'e-mail': false,
    'cpf': false,
    'password': false,
    'confirmar password': false,
  };
  
  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((label, node) {
      node.addListener(() {
        if (node.hasFocus) {
          setState(() {
            _campoTocado[label] = true;
          });
        }
      });
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
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(value);
  }

  bool cpfValido(String value) {
    final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
    return cpfRegex.hasMatch(value.trim());
  }

  bool passwordForte(String password) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$');
    return regex.hasMatch(password);
  }

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

  void atualizarCpfVisual(String valor) {
    setState(() {
      cpfValidoVisual = valor.trim().isEmpty ? null : cpfValido(valor);
    });
  }

  void atualizarpasswordVisual(String valor) {
    setState(() {
      passwordValidaVisual = valor.trim().isEmpty ? null : passwordForte(valor);
      confirmarpasswordValida = valor == _confirmarpasswordController.text;
    });
  }

  void atualizarConfirmarpasswordVisual(String valor) {
    setState(() {
      confirmarpasswordValida =
          valor.trim().isEmpty ? null : valor == _passwordController.text;
    });
  }

  bool camposValidos() {
    return (_formKey.currentState?.validate() ?? false) &&
        nomeValidoVisual == true &&
        emailValidoVisual == true &&
        cpfValidoVisual == true &&
        passwordValidaVisual == true &&
        confirmarpasswordValida == true &&
        _aceitaPolitica;
  }

  Future<void> _cadastrar() async {
    if (!camposValidos()) return;

    setState(() => _enviando = true);

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final sucesso = await loginProvider.cadastrar(
      _nomeController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );

    setState(() => _enviando = false);

    if (!sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erro ao cadastrar. Tente novamente.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // POP-UP DE SUCESSO
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: AlertDialog(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1A1A1A)
                : const Color(0xFFF9FAFB),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            contentPadding: const EdgeInsets.all(28),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, color: Color(0xFF0A84FF), size: 40),
                const SizedBox(height: 20),
                Text(
                  'Cadastro concluído!',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.party_mode, color: Color(0xFFFFD700), size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Bem-vinda, ${_nomeController.text.split(' ').first}!',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.favorite, color: Color(0xFF0A84FF), size: 16),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Agora você faz parte da Paw Proteticare — juntos, vamos transformar vidas 💙',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black54,
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const Login(),
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionsBuilder: (context, animation, _, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(const Color(0xFF0A84FF)),
                ),
                child: Text(
                  'Ir para o login',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB);
    final containerColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF0A2E5C);
    final textSecondary = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4B5563);
    final inputFill = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF9FAFB);
    final inputBorder = isDark ? const Color(0xFF3A3A3C) : const Color(0xFFD1D5DB);
    final iconColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final placeholderColor = isDark ? const Color(0xFF6B6B6B) : const Color(0xFF9CA3AF);
    final buttonColor = camposValidos()
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
              constraints: const BoxConstraints(minHeight: 650),
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
                          Center(
                            child: Text(
                              "Crie sua conta",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Center(
                            child: Text(
                              "Cadastre-se para apoiar o resgate e a reabilitação de animais.",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textSecondary,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 28),
                          _buildTextField(
                            "Nome completo",
                            controller: _nomeController,
                            hintText: "Ex: João Silva",
                            valido: nomeValidoVisual,
                            mensagemFeedbackValido: "✓ Nome válido",
                            mensagemFeedbackInvalido: "Use nome e sobrenome com iniciais maiúsculas",
                            onChanged: atualizarNomeVisual,
                            prefixIcon: Icon(Icons.person_outline, color: iconColor),
                            inputFill: inputFill,
                            textPrimary: textPrimary,
                            placeholderColor: placeholderColor,
                            inputBorder: inputBorder,
                            iconColor: iconColor,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            "E-mail",
                            controller: _emailController,
                            hintText: "seu@email.com",
                            valido: emailValidoVisual,
                            mensagemFeedbackValido: "✓ E-mail válido",
                            mensagemFeedbackInvalido: "E-mail inválido",
                            onChanged: atualizarEmailVisual,
                            prefixIcon: Icon(Icons.email_outlined, color: iconColor),
                            inputFill: inputFill,
                            textPrimary: textPrimary,
                            placeholderColor: placeholderColor,
                            inputBorder: inputBorder,
                            iconColor: iconColor,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            "CPF",
                            controller: _cpfController,
                            hintText: "000.000.000-00",
                            valido: cpfValidoVisual,
                            mensagemFeedbackValido: "✓ CPF válido",
                            mensagemFeedbackInvalido: "CPF inválido",
                            onChanged: atualizarCpfVisual,
                            prefixIcon: Icon(Icons.badge_outlined, color: iconColor),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                            inputFill: inputFill,
                            textPrimary: textPrimary,
                            placeholderColor: placeholderColor,
                            inputBorder: inputBorder,
                            iconColor: iconColor,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            "password",
                            controller: _passwordController,
                            obscureText: !_passwordVisivel,
                            hintText: "Mínimo 8 caracteres, com letras, números e símbolos",
                            valido: passwordValidaVisual,
                            mensagemFeedbackValido: "✓ password forte",
                            mensagemFeedbackInvalido: "Use maiúscula, minúscula, número e símbolo",
                            onChanged: atualizarpasswordVisual,
                            prefixIcon: Icon(Icons.lock_outline, color: iconColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisivel ? Icons.visibility : Icons.visibility_off,
                                color: iconColor,
                              ),
                              onPressed: () => setState(() => _passwordVisivel = !_passwordVisivel),
                            ),
                            inputFill: inputFill,
                            textPrimary: textPrimary,
                            placeholderColor: placeholderColor,
                            inputBorder: inputBorder,
                            iconColor: iconColor,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            "Confirmar password",
                            controller: _confirmarpasswordController,
                            obscureText: !_confirmarpasswordVisivel,
                            hintText: "Repita a password",
                            valido: confirmarpasswordValida,
                            mensagemFeedbackValido: "✓ passwords coincidem",
                            mensagemFeedbackInvalido: "As passwords não são iguais",
                            onChanged: atualizarConfirmarpasswordVisual,
                            prefixIcon: Icon(Icons.lock_outline, color: iconColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmarpasswordVisivel ? Icons.visibility : Icons.visibility_off,
                                color: iconColor,
                              ),
                              onPressed: () => setState(() => _confirmarpasswordVisivel = !_confirmarpasswordVisivel),
                            ),
                            inputFill: inputFill,
                            textPrimary: textPrimary,
                            placeholderColor: placeholderColor,
                            inputBorder: inputBorder,
                            iconColor: iconColor,
                          ),
                          const SizedBox(height: 20),
                          CheckboxListTile(
                            title: RichText(
                              text: TextSpan(
                                text: 'Eu concordo com a ',
                                style: GoogleFonts.poppins(fontSize: 13, color: textSecondary),
                                children: [
                                  TextSpan(
                                    text: 'política de privacidade',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: linkColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _aceitaPolitica,
                            onChanged: (value) {
                              setState(() {
                                _aceitaPolitica = value ?? false;
                              });
                            },
                            activeColor: linkColor,
                            checkColor: Colors.white,
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: _enviando ? null : camposValidos() ? _cadastrar : null,
                              icon: _enviando
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
                                _enviando ? "Cadastrando..." : "Cadastrar",
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
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Já tem conta? ",
                                style: GoogleFonts.poppins(fontSize: 14, color: textSecondary),
                                children: [
                                  TextSpan(
                                    text: "Fazer login",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: linkColor,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => const Login(),
                                            transitionDuration: const Duration(milliseconds: 300),
                                            transitionsBuilder: (context, animation, _, child) {
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
                  const SizedBox(height: 24),
                ],
              ),
            ),
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
    required Color inputFill,
    required Color textPrimary,
    required Color placeholderColor,
    required Color inputBorder,
    required Color iconColor,
  }) {
    final bool campoVazio = controller.text.trim().isEmpty;
    final bool perdeuFoco = !_focusNodes[label.toLowerCase()]!.hasFocus;
    final bool tocado = _campoTocado[label.toLowerCase()] ?? false;
    final bool mostrarErro = campoVazio && perdeuFoco && tocado;

    Color bordaColor;
    if (mostrarErro) {
      bordaColor = Colors.redAccent;
    } else if (valido == true) {
      bordaColor = Colors.green;
    } else if (_focusNodes[label.toLowerCase()]!.hasFocus) {
      bordaColor = const Color(0xFF0A84FF);
    } else {
      bordaColor = inputBorder;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          focusNode: _focusNodes[label.toLowerCase()],
          style: TextStyle(color: textPrimary, fontSize: 16),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: placeholderColor),
            hintText: hintText,
            hintStyle: TextStyle(color: placeholderColor),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: IconTheme(data: IconThemeData(color: iconColor, size: 20), child: prefixIcon ?? const SizedBox()),
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: inputFill,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: bordaColor, width: 1.5)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: bordaColor, width: 2)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            mostrarErro
                ? 'Campo obrigatório'
                : (valido == true ? mensagemFeedbackValido : (tocado ? mensagemFeedbackInvalido : '')),
            style: TextStyle(
              color: mostrarErro
                  ? Colors.redAccent
                  : (valido == true ? Colors.green : (tocado ? Colors.redAccent : Colors.transparent)),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
