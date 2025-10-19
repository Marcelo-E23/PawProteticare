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

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "🎉 Interesse enviado com sucesso!",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xff010d50),
            ),
          ),
          content: Text(
            "A ONG entrará em contato com você em breve para continuar o processo de adoção.",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: Text(
                "Voltar para pets disponíveis",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff010d50),
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
    final textColor = isDark ? Colors.white : const Color(0xFF000000);
    final labelColor = isDark ? Colors.white70 : const Color(0xFF444444);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Formulário de Adoção de ${widget.nomeAnimal}",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff010d50),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.imagemPath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      semanticLabel: 'Foto do pet ${widget.nomeAnimal}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nomeAnimal,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor)),
                      const SizedBox(height: 4),
                      Text("Idade: ${widget.idade}",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: const Color(0xFF555555))),
                      Text("Raça: ${widget.raca}",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: const Color(0xFF555555))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  _buildCampo(
                    "Nome completo *",
                    _nomeController,
                    labelColor,
                    textColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Campo obrigatório";
                      }

                      final partes = value.trim().split(RegExp(r'\s+'));
                      if (partes.length < 2) {
                        return "Digite nome e sobrenome";
                      }

                      for (final parte in partes) {
                        if (!RegExp(r'^[A-ZÀ-Ÿ][a-zà-ÿ\-]*$').hasMatch(parte)) {
                          return "Use iniciais maiúsculas (ex: João Silva)";
                        }
                      }

                      return null;
                    },
                  ),
                  _buildCampo(
                    "CPF *",
                    _cpfController,
                    labelColor,
                    textColor,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                    hintText: "000.000.000-00",
                    validator: (value) {
                      final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
                      if (value == null || !cpfRegex.hasMatch(value)) {
                        return "CPF inválido";
                      }
                      return null;
                    },
                  ),
                  _buildCampo(
                    "Telefone *",
                    _telefoneController,
                    labelColor,
                    textColor,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    keyboardType: TextInputType.phone,
                    hintText: "(99) 99999-9999",
                    validator: (value) {
                      final telRegex = RegExp(r'^\(\d{2}\) \d{4,5}-\d{4}$');
                      if (value == null || !telRegex.hasMatch(value)) {
                        return "Telefone inválido";
                      }
                      return null;
                    },
                  ),
                  _buildCampo(
                    "CEP *",
                    _cepController,
                    labelColor,
                    textColor,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                    hintText: "00000-000",
                    validator: (value) {
                      final cepRegex = RegExp(r'^\d{5}-\d{3}$');
                      if (value == null || !cepRegex.hasMatch(value)) {
                        return "CEP inválido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Tipo de residência *",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: labelColor)),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _residencia,
                    items: ["Casa", "Apartamento", "Chácara", "Outro"]
                        .map((tipo) => DropdownMenuItem(
                              value: tipo,
                              child: Text(tipo,
                                  style: GoogleFonts.poppins(
                                      color: textColor, fontSize: 14)),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _residencia = value!),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.lock,
                          size: 16, color: Color(0xFF555555)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Seus dados são usados apenas para contato da adoção e não serão compartilhados com terceiros.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: labelColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _enviando ? null : _enviarFormulario,
                      icon: const Icon(Icons.pets),
                      label: Text(
                        "Quero adotar ${widget.nomeAnimal} ❤️",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff010d50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
          labelText: label,
          hintText: hintText,
          labelStyle: GoogleFonts.poppins(
            color: labelColor,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          errorStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
