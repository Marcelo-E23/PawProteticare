import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:projetotcc/service/usuario_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/doacao_provider.dart';
import '../provider/login_provider.dart';
import '../models/doacao_model.dart';
import '../models/usuario_model.dart' hide UsuarioModel;

class DoacaoPage extends StatefulWidget {
  const DoacaoPage({super.key});

  @override
  State<DoacaoPage> createState() => _DoacaoPageState();
}

class _DoacaoPageState extends State<DoacaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _valorController = TextEditingController();
  String _tipoDoacao = "Dinheiro";
  String? _localSelecionado;
  bool _confirmando = false;

  final Map<String, IconData> iconesDoacao = {
    "Dinheiro": Icons.monetization_on,
    "Ração": Icons.local_grocery_store,
    "Acessórios": Icons.inventory_2,
  };

  final Map<String, List<Map<String, String>>> enderecos = {
    "Ração": [
      {
        "nome": "MedCenterPet",
        "endereco": "Av. Brg. Manoel Rodrigues Jordão, 1742 - Jardim Silveira, Barueri",
        "horario": "Seg a Sáb, 8h às 22h",
        "mapa": "https://www.google.com/maps?q=MedCenterPet+Barueri"
      },
      {
        "nome": "Big Dog – Pet shop e Clínica Veterinária",
        "endereco": "Av. Zélia, 225 - Parque dos Camargos, Barueri",
        "horario": "Seg a Sáb, 8h às 19h",
        "mapa": "https://www.google.com/maps?q=Big+Dog+Barueri"
      },
    ],
    "Acessórios": [
      {
        "nome": "Centro Veterinário Cães e Gatos 24H",
        "endereco": "R. Narciso Sturlini, 186 - Centro, Osasco",
        "horario": "24h",
        "mapa": "https://www.google.com/maps?q=Centro+Veterinário+Osasco"
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if (loginProvider.nomeUsuario != null) {
      _nomeController.text = loginProvider.nomeUsuario!;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  bool _podeConfirmar() {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (_tipoDoacao == "Dinheiro") {
      final valorPreenchido = _valorController.text.trim().isNotEmpty;
      return formValido && valorPreenchido;
    } else {
      return formValido && _localSelecionado != null;
    }
  }

  void definirValor(double valor) {
    setState(() {
      _valorController.text = 'R\$ ${valor.toStringAsFixed(0)},00';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loginProvider = Provider.of<LoginProvider>(context);
    final nomeUsuario = loginProvider.nomeUsuario ?? "Amigo";

    if (nomeUsuario != "Amigo" && _nomeController.text.isEmpty) {
      _nomeController.text = nomeUsuario;
    }

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2E5C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Icon(Icons.pets, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(
              "Sua ajuda salva vidas hoje",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 19),
                    Text(
                      "Mais de 30 milhões de animais vivem nas ruas do Brasil. Sua ajuda pode dar a eles uma segunda chance.",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : const Color(0xFF4B5563),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 27),

                    // Tipo de Doação
                    Text(
                      "Como você quer ajudar?",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _tipoDoacao,
                      items: ["Dinheiro", "Ração", "Acessórios"].map((tipo) {
                        final icon = iconesDoacao[tipo];
                        return DropdownMenuItem(
                          value: tipo,
                          child: Row(
                            children: [
                              Icon(icon, size: 20, color: isDark ? Colors.white : Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                tipo,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _tipoDoacao = value!;
                          _localSelecionado = null;
                          _valorController.clear();
                        });
                      },
                      decoration: estiloCampo("Escolha como ajudar", isDark, icon: iconesDoacao[_tipoDoacao]),
                    ),
                    const SizedBox(height: 30),

                    // Campos de Nome/CPF
                    Text(
                      "Seus dados",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nomeController,
                      decoration: estiloCampo("Nome completo", isDark, icon: Icons.person_outline),
                      validator: (value) => value?.trim().isEmpty ?? true ? 'Informe seu nome' : null,
                    ),
                    const SizedBox(height: 16),
                    if (_tipoDoacao == "Dinheiro")
                      TextFormField(
                        controller: _cpfController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        decoration: estiloCampo("CPF", isDark, icon: Icons.badge_outlined),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Informe seu CPF';
                          final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
                          return cpfRegex.hasMatch(value) ? null : 'CPF inválido';
                        },
                      ),
                    const SizedBox(height: 30),

                    // Campos de Doação
                    if (_tipoDoacao == "Dinheiro") ...[
                      Text(
                        "Escolha o valor",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [25, 50, 100].map((valor) {
                          final valorFormatado = 'R\$ $valor,00';
                          final isSelected = _valorController.text.trim() == valorFormatado;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              onPressed: () => definirValor(valor.toDouble()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected
                                    ? const Color(0xFF0A84FF)
                                    : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF5F5F5)),
                                foregroundColor: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                elevation: 0,
                              ),
                              child: Text(
                                "R\$ $valor",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: _valorController,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          MoneyInputFormatter(
                            leadingSymbol: 'R\$ ',
                            useSymbolPadding: true,
                            thousandSeparator: ThousandSeparator.Period,
                            mantissaLength: 2,
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return null;
                          final valorLimpo = value.replaceAll(RegExp(r'[^\d,]'), '');
                          final valorNumerico = double.tryParse(valorLimpo.replaceAll(',', '.'));
                          if (valorNumerico == null) return 'Valor inválido';
                          if (valorNumerico < 1.0) return 'Mínimo: R\$1,00';
                          if (valorNumerico > 9999.99) return 'Máximo: R\$9999,99';
                          return null;
                        },
                        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 16),
                        decoration: estiloCampo("Outro valor (R\$)", isDark, icon: Icons.attach_money)
                            .copyWith(hintText: "Ex: R\$ 75,00"),
                      ),
                    ],

                    if (_tipoDoacao == "Ração" || _tipoDoacao == "Acessórios") ...[
                      const SizedBox(height: 27),
                      Text(
                        "Local de entrega",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...?enderecos[_tipoDoacao]?.map((local) {
                        final isSelecionado = _localSelecionado == local['nome'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _localSelecionado = local['nome']!;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isSelecionado
                                  ? const Color(0xFF0A84FF).withOpacity(0.1)
                                  : (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5)),
                              border: Border.all(
                                color: isSelecionado ? const Color(0xFF0A84FF) : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Color(0xFF0A84FF), size: 20),
                                    const SizedBox(width: 6),
                                    Text(
                                      local['nome']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  local['endereco']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: isDark ? Colors.white70 : Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      local['horario']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: isDark ? Colors.white60 : Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF1F1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.warning, color: Color(0xFFB91C1C), size: 18),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Verifique se o local está aberto antes de confirmar.",
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: const Color(0xFFB91C1C),
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
                      }),
                    ],

                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ),

            // Botão de confirmar
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: AnimatedScale(
                scale: _confirmando ? 0.95 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: ElevatedButton.icon(
                  onPressed: _podeConfirmar() && !_confirmando
                      ? () async {
                          setState(() => _confirmando = true);
                          await _confirmarDoacao(loginProvider);
                          setState(() => _confirmando = false);
                        }
                      : null,
                  icon: _confirmando
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.check, size: 20, color: Colors.white),
                  label: Text(
                    _confirmando ? "Confirmando..." : "Confirmar Doação",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _podeConfirmar() ? const Color(0xFF0A2E5C) : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration estiloCampo(String label, bool isDark, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      hintStyle: TextStyle(
        color: isDark ? Colors.white54 : Colors.grey[500],
      ),
      prefixIcon: icon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                icon,
                size: 22,
                color: isDark ? Colors.white : Colors.grey[700],
              ),
            )
          : null,
      filled: true,
      fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.grey[600]! : Colors.grey[400]!,
          width: 1,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Color(0xFF0A84FF), width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
      labelStyle: TextStyle(
        color: isDark ? Colors.white70 : Colors.grey[800],
      ),
      errorStyle: const TextStyle(
        fontSize: 12,
        color: Colors.redAccent,
      ),
    );
  }

  Future<void> _confirmarDoacao(LoginProvider loginProvider) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final nome = _nomeController.text.trim();
    final cpf = _cpfController.text.trim();

    final usuario = UsuarioModel(nome: nome, cpf: cpf);

    final tipo = _tipoDoacao;
    final valor = _valorController.text.trim();

    final doacao = DoacaoModel(
      tipo: tipo,
      valor: tipo == "Dinheiro" ? double.tryParse(valor.replaceAll(RegExp(r'[^\d.]'), '')) : null,
      usuario: usuario,
      dataDoacao: DateTime.now(),
    );

    try {
      await Provider.of<DoacaoProvider>(context, listen: false)
          .adicionarDoacao(doacao, loginProvider.token!);

      if (loginProvider.nomeUsuario == null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nomeUsuario', nome);
        await prefs.setString('cpfUsuario', cpf);
      }

      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Confirmação",
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Color(0xFF0A84FF), size: 64),
                  const SizedBox(height: 20),
                  Text(
                    "Parabéns, $nome!",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0A2E5C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Sua doação foi confirmada com sucesso.",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: isDark ? Colors.white70 : const Color(0xFF4B5563),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Obrigado por fazer a diferença.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: isDark ? Colors.white60 : const Color(0xFF6B7280),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text("Fechar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A2E5C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      textStyle: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      _valorController.clear();
      _nomeController.clear();
      _cpfController.clear();
      _localSelecionado = null;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao enviar doação: $e')));
    }
  }
}
