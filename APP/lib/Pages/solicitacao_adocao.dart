import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:google_fonts/google_fonts.dart';

class InteresseAdocaoPage extends StatefulWidget {
  final String nomeAnimal;
  final String idade;
  final String raca;
  final String imagemPath;

  const InteresseAdocaoPage({
    required this.nomeAnimal,
    required this.idade,
    required this.raca,
    required this.imagemPath,
    super.key,
  });

  @override
  State<InteresseAdocaoPage> createState() => _InteresseAdocaoPageState();
}

class _InteresseAdocaoPageState extends State<InteresseAdocaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cepController = TextEditingController();
  String _residencia = 'Casa';
  bool _enviando = false;

  String formatarNome(String nome) {
    final partes = nome.trim().split(RegExp(r'\s+'));
    return partes.map((parte) {
      final lower = parte.toLowerCase();
      return lower[0].toUpperCase() + lower.substring(1);
    }).join(' ');
  }

  bool validarNomeCompleto(String nome) {
    final partes = nome.trim().split(RegExp(r'\s+'));
    if (partes.length < 2) return false;

    for (final parte in partes) {
      if (!RegExp(r'^[A-ZÀ-Ÿ][a-zà-ÿ\-]*$').hasMatch(parte)) return false;
    }

    return true;
  }

  void _enviarFormulario() {
    if (!_formKey.currentState!.validate()) return;

    final nomeFormatado = formatarNome(_nomeController.text);
    _nomeController.text = nomeFormatado;

    setState(() => _enviando = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _enviando = false);
      final isDark = Theme.of(context).brightness == Brightness.dark;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor:
              isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9FAFB),
          elevation: 8,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          title: Row(
            children: [
              const Text("🐾 ", style: TextStyle(fontSize: 24)),
              Expanded(
                child: Text(
                  "Interesse enviado com sucesso!",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? const Color(0xFF007AFF)
                        : const Color(0xff23476d),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "A ONG entrará em contato com você em até 24h para finalizar a adoção.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDark
                      ? const Color(0xFFEEEEEE)
                      : const Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Precisa de ajuda? contato@ong.com.br",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color(0xFF007AFF),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.pets, color: Colors.white),
              label: Text(
                "Voltar para pets disponíveis",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor:
                    isDark ? const Color(0xff234161) : const Color(0xFF264580),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? const Color(0xFFEEEEEE) : const Color(0xFF333333);
    final labelColor =
        isDark ? const Color(0xFFAAAAAA) : const Color(0xFF555555);
    final inputFillColor =
        isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF5F6F7);
    final borderInactive =
        isDark ? const Color(0xFF444444) : const Color(0xFFE0E0E0);
    final borderActive = const Color(0xFF007AFF);
    final placeholderColor =
        isDark ? const Color(0xFFAAAAAA) : const Color(0xFF888888);
    final iconColor =
        isDark ? const Color(0xFFEEEEEE) : const Color(0xFF888888);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          "Adoção de ${widget.nomeAnimal}",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor:
            const Color(0xFF1A4D8F), // 🔥 MELHORIA: azul escuro da paleta
        foregroundColor: Colors.white, // 🔥 MELHORIA: ícone de voltar branco
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF5F6F7),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        12), // 🔥 MELHORIA: imagem quadrivulada
                    child: Image.asset(
                      widget.imagemPath,
                      width: 100, // 🔥 MELHORIA: imagem ampliada
                      height: 100,
                      fit: BoxFit.cover,
                      semanticLabel: 'Foto do pet ${widget.nomeAnimal}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nomeAnimal,
                        style: GoogleFonts.poppins(
                          fontSize: 24, // 🔥 MELHORIA: nome com destaque
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Idade: ${widget.idade}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: labelColor,
                        ),
                      ),
                      Text(
                        "Raça: ${widget.raca}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: labelColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode
                  .onUserInteraction, // 🔥 MELHORIA: validação em tempo real
              child: Column(
                children: [
                  _buildCampo(
                      "Nome completo *", _nomeController, labelColor, textColor,
                      validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Campo obrigatório";
                    }
                    if (!validarNomeCompleto(value)) {
                      return "Digite nome e sobrenome válidos";
                    }
                    return null;
                  }),
                  _buildCampo("CPF *", _cpfController, labelColor, textColor,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(), // formata como 000.000.000-00
                      ],
                      keyboardType: TextInputType.number,
                      hintText: "000.000.000-00", validator: (value) {
                    final cpfRegex = RegExp(
                        r'^\d{3}\.\d{3}\.\d{3}-\d{2}$'); // exige formato com pontos e hífen
                    if (value == null || !cpfRegex.hasMatch(value.trim())) {
                      return "CPF inválido";
                    }
                    return null;
                  }),
                  _buildCampo(
                      "Telefone *", _telefoneController, labelColor, textColor,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      keyboardType: TextInputType.phone,
                      hintText: "(99) 99999-9999", validator: (value) {
                    final telRegex = RegExp(r'^\(\d{2}\) \d{4,5}-\d{4}$');
                    if (value == null || !telRegex.hasMatch(value))
                      return "Telefone inválido";
                    return null;
                  }),
                  _buildCampo("CEP *", _cepController, labelColor, textColor,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'\d|-')), // permite só números e hífen
                      ],
                      keyboardType: TextInputType.number,
                      hintText: "00000-000", validator: (value) {
                    final cepRegex = RegExp(
                        r'^\d{5}-\d{3}$'); // exige 5 dígitos + hífen + 3 dígitos
                    if (value == null || !cepRegex.hasMatch(value.trim())) {
                      return "CEP inválido";
                    }
                    return null;
                  }),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Tipo de residência *",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: labelColor)),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // 🔥 MELHORIA: altura e largura padronizadas no dropdown
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 56,
                    child: DropdownButtonFormField<String>(
                      value: _residencia,
                      items: ["Casa", "Apartamento", "Chácara", "Outro"]
                          .map((tipo) => DropdownMenuItem(
                                value: tipo,
                                child: Text(
                                  tipo,
                                  style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _residencia = value!),
                      decoration: InputDecoration(
                        helperText: ' ',
                        filled: true,
                        fillColor: inputFillColor,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderInactive),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderInactive),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderActive, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFE53935), width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFE53935), width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Icon(Icons.lock, size: 16, color: iconColor),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Seus dados são usados apenas para contato da adoção e não serão compartilhados com terceiros.",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: labelColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _enviando ? null : _enviarFormulario,
                      icon: const Icon(Icons.pets),
                      label: Text(
                        "Quero adotar ${widget.nomeAnimal}",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A4D8F),

                        /// 🔥 MELHORIA: botão turquesa vibrante
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF444444),
                        disabledForegroundColor: Colors.white70,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              14), // 🔥 MELHORIA: borda arredondada
                        ),
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔧 Campo de texto reutilizável com altura e largura padronizadas
  Widget _buildCampo(
    String label,
    TextEditingController controller,
    Color labelColor,
    Color textColor, {
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inputFillColor =
        isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF5F6F7);
    final borderInactive =
        isDark ? const Color(0xFF444444) : const Color(0xFFE0E0E0);
    final borderActive = const Color(0xFF007AFF);
    final placeholderColor =
        isDark ? const Color(0xFFAAAAAA) : const Color(0xFF888888);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.9, // 🔥 MELHORIA: largura uniforme
        height: 56, // 🔥 MELHORIA: altura uniforme
        child: TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            labelText: label,
            hintText: hintText,
            labelStyle: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: GoogleFonts.poppins(
              color: placeholderColor,
            ),
            filled: true,
            fillColor: inputFillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderInactive),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderInactive),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderActive, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Color(0xFFE53935),
                  width: 2), // 🔥 MELHORIA: borda vermelha em erro
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
            ),
            errorStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.redAccent,
              height: 1.2, // 🔥 MELHORIA: evita quebra de layout
            ),
          ),
        ),
      ),
    );
  }
}
