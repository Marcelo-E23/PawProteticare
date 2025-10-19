import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:projetotcc/Pages/login.dart';

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
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  final Map<String, FocusNode> _focusNodes = {
    'nome completo': FocusNode(),
    'e-mail': FocusNode(),
    'cpf': FocusNode(),
    'senha': FocusNode(),
    'confirmar senha': FocusNode(),
  };

  bool _senhaVisivel = false;
  bool _confirmarSenhaVisivel = false;
  bool _aceitaPolitica = false;
  bool _enviando = false;

  bool? nomeValidoVisual;
  bool? emailValidoVisual;
  bool? cpfValidoVisual;
  bool? senhaValidaVisual;
  bool? confirmarSenhaValida;

  final Map<String, bool> _campoTocado = {
    'nome completo': false,
    'e-mail': false,
    'cpf': false,
    'senha': false,
    'confirmar senha': false,
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

  bool senhaForte(String senha) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$');
    return regex.hasMatch(senha);
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

  void atualizarSenhaVisual(String valor) {
    setState(() {
      senhaValidaVisual = valor.trim().isEmpty ? null : senhaForte(valor);
      confirmarSenhaValida = valor == _confirmarSenhaController.text;
    });
  }

  void atualizarConfirmarSenhaVisual(String valor) {
    setState(() {
      confirmarSenhaValida =
          valor.trim().isEmpty ? null : valor == _senhaController.text;
    });
  }

  bool camposValidos() {
    return (_formKey.currentState?.validate() ?? false) &&
        nomeValidoVisual == true &&
        emailValidoVisual == true &&
        cpfValidoVisual == true &&
        senhaValidaVisual == true &&
        confirmarSenhaValida == true &&
        _aceitaPolitica;
  }

  void _cadastrar() async {
    if (!camposValidos()) return;
    setState(() => _enviando = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _enviando = false);

    // ✅ POP-UP DE SUCESSO COM TODAS AS MELHORIAS
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: FadeTransition(
            opacity: CurvedAnimation(parent: __, curve: Curves.easeOut),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: __, curve: Curves.easeOut)),
              child: AlertDialog(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF1A1A1A)
                    : const Color(0xFFF9FAFB),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                contentPadding: const EdgeInsets.all(28),
                insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                elevation: 8, // ✅ sombra leve
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ✅ ÍCONE MENOR (40px)
                    const Icon(
                      Icons.check_circle_outline,
                      color: Color(0xFF0A84FF),
                      size: 40,
                    ),
                    const SizedBox(height: 20), // ✅ mais espaço

                    // ✅ TÍTULO
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
                    const SizedBox(height: 12), // ✅ mais espaço

                    // ✅ MENSAGEM EMOCIONAL COM ÍCONE VETORIAL
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
                        const Icon(
                          Icons.favorite,
                          color: Color(0xFF0A84FF),
                          size: 16, // ✅ coração menor e vetorial
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // ✅ SUBTÍTULO MAIS EMOCIONAL
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
                    // ✅ CORREÇÃO: usar ButtonStyle para overlayColor
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFF0A84FF)),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return const Color(0xFF0A84FF).withOpacity(0.2);
                        }
                        return null;
                      }),
                    ),
                    child: Text(
                      'Ir para o login',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // ✅ FECHA AUTOMATICAMENTE APÓS 2 SEGUNDOS
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  } // 👈 FALTAVA ESTE FECHAMENTO!

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
                          // ✅ TÍTULO E SUBTÍTULO NOVOS
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

                          // ✅ CAMPOS (com lógica original)
                          _buildTextField(
                            "Nome completo",
                            controller: _nomeController,
                            hintText: "Ex: João Silva",
                            valido: nomeValidoVisual,
                            mensagemFeedbackValido: "✓ Nome válido",
                            mensagemFeedbackInvalido:
                                "Use nome e sobrenome com iniciais maiúsculas",
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
                            "Senha",
                            controller: _senhaController,
                            obscureText: !_senhaVisivel,
                            hintText: "Mínimo 8 caracteres, com letras, números e símbolos",
                            valido: senhaValidaVisual,
                            mensagemFeedbackValido: "✓ Senha forte",
                            mensagemFeedbackInvalido:
                                "Use maiúscula, minúscula, número e símbolo",
                            onChanged: atualizarSenhaVisual,
                            prefixIcon: Icon(Icons.lock_outline, color: iconColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                                color: iconColor,
                              ),
                              onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                            ),
                            inputFill: inputFill,
                            textPrimary: textPrimary,
                            placeholderColor: placeholderColor,
                            inputBorder: inputBorder,
                            iconColor: iconColor,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            "Confirmar senha",
                            controller: _confirmarSenhaController,
                            obscureText: !_confirmarSenhaVisivel,
                            hintText: "Repita a senha",
                            valido: confirmarSenhaValida,
                            mensagemFeedbackValido: "✓ Senhas coincidem",
                            mensagemFeedbackInvalido: "As senhas não são iguais",
                            onChanged: atualizarConfirmarSenhaVisual,
                            prefixIcon: Icon(Icons.lock_outline, color: iconColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmarSenhaVisivel
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: iconColor,
                              ),
                              onPressed: () => setState(
                                  () => _confirmarSenhaVisivel = !_confirmarSenhaVisivel),
                            ),
                            inputFill: inputFill,
                            textPrimary: textPrimary,
                            placeholderColor: placeholderColor,
                            inputBorder: inputBorder,
                            iconColor: iconColor,
                          ),

                          const SizedBox(height: 20),

                          // ✅ CHECKBOX
                          CheckboxListTile(
                            title: RichText(
                              text: TextSpan(
                                text: 'Eu concordo com a ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: textSecondary,
                                ),
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
                            tileColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),

                          const SizedBox(height: 20),

                          // ✅ BOTÃO COM LOADING
                          SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: _enviando
                                  ? null
                                  : camposValidos()
                                      ? () => _cadastrar()
                                      : null,
                              icon: _enviando
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(Colors.white),
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

                          // ✅ LINK COM TRANSIÇÃO SUAVE
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Já tem conta? ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: textSecondary,
                                ),
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
                                            transitionDuration:
                                                const Duration(milliseconds: 300),
                                            transitionsBuilder:
                                                (context, animation, _, child) {
                                              return FadeTransition(
                                                  opacity: animation, child: child);
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

                  // ✅ ESPAÇO PARA ILUSTRAÇÃO (opcional)
                  const SizedBox(height: 24),
                  // Descomente abaixo se tiver a imagem:
                  // Image.asset(
                  //   'assets/images/pet-footer.png',
                  //   height: 60,
                  //   width: 60,
                  //   fit: BoxFit.contain,
                  //   errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  // ),
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

    final Color fundoInput = inputFill;
    final Color textoInput = textPrimary;
    final Color placeholder = placeholderColor;
    const Color bordaErro = Colors.redAccent;
    const Color bordaCorreto = Colors.green;
    const Color bordaAtiva = Color(0xFF0A84FF);
    final Color bordaInativa = inputBorder;

    Color bordaColor;
    if (mostrarErro) {
      bordaColor = bordaErro;
    } else if (valido == true) {
      bordaColor = bordaCorreto;
    } else if (_focusNodes[label.toLowerCase()]!.hasFocus) {
      bordaColor = bordaAtiva;
    } else {
      bordaColor = bordaInativa;
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
          style: TextStyle(color: textoInput, fontSize: 16),
          textInputAction: label == 'Confirmar senha'
              ? TextInputAction.done
              : TextInputAction.next,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: placeholder),
            hintText: hintText,
            hintStyle: TextStyle(color: placeholder),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: IconTheme(
                data: IconThemeData(color: iconColor, size: 20),
                child: prefixIcon ?? const SizedBox(),
              ),
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fundoInput,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: bordaColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: bordaColor, width: 2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            mostrarErro
                ? 'Campo obrigatório'
                : (valido == true
                    ? mensagemFeedbackValido
                    : (tocado ? mensagemFeedbackInvalido : '')),
            style: TextStyle(
              color: mostrarErro
                  ? bordaErro
                  : (valido == true
                      ? bordaCorreto
                      : (tocado ? bordaErro : Colors.transparent)),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}