import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:projetotcc/provider/doacao_provider.dart';

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
  final _nomeRacaoController = TextEditingController();
  final _nomeAcessoriosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        title: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text("Faça sua Doação",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sua doação ajuda animais resgatados a receberem cuidados enquanto esperam por um lar cheio de amor.",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.grey[800]),
              ),
              const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("Tipo de Doação",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black)),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _tipoDoacao,
                items: ["Dinheiro", "Ração", "Acessórios"]
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo,
                              style: GoogleFonts.poppins(
                                  color:
                                      isDark ? Colors.white : Colors.black87)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _tipoDoacao = value!;
                  });
                },
                decoration: estiloCampo("Selecione", isDark,
                    icon: Icons.category_outlined),
              ),
              const SizedBox(height: 24),
              _buildDetalhes(theme),
            ],
          ),
        ),
      ),
    );
  }

  String _tipoDoacao = "Dinheiro";
  final List<Map<String, dynamic>> historicoDoacoes = [];

  final Map<String, List<Map<String, String>>> enderecos = {
    "Ração": [
      {
        "nome": "MedCenterPet",
        "endereco":
            "Av. Brg. Manoel Rodrigues Jordão, 1742 - Jardim Silveira, Barueri - SP",
        "horario": "Seg a Sáb, das 8h às 22h",
      },
      {
        "nome": "Big Dog - Pet shop e Clínica Veterinária",
        "endereco": "Av. Zélia, 225 - Parque dos Camargos, Barueri - SP",
        "horario": "Seg a Sáb, das 8h às 19h",
      },
    ],
    "Acessórios": [
      {
        "nome": "Centro Veterinário Cães e Gatos 24H",
        "endereco": "R. Narciso Sturlini, 186 - Centro, Osasco - SP",
        "horario": "24h",
      },
    ],
  };

  String formatarNome(String nome) {
    final partes = nome.trim().split(RegExp(r'\s+'));
    return partes
        .map((p) => p.isEmpty
            ? ''
            : '${p[0].toUpperCase()}${p.substring(1).toLowerCase()}')
        .join(' ');
  }

  String? validarNome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite seu nome completo';
    }
    final partes = value.trim().split(RegExp(r'\s+'));
    if (partes.length < 2) {
      return 'Digite nome e sobrenome';
    }
    final nomeInvalido =
        partes.any((p) => !RegExp(r'^[A-Za-zÀ-ÿ]+$').hasMatch(p));
    if (nomeInvalido) {
      return 'O nome deve conter apenas letras';
    }
    return null;
  }

  InputDecoration estiloCampo(String label, bool isDark,
      {IconData? icon, String? prefixText}) {
    return InputDecoration(
      labelText: label,
      prefixText: prefixText,
      prefixIcon: icon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8, right: 4),
              child: Icon(icon,
                  size: 20, color: isDark ? Colors.white70 : Colors.grey),
            )
          : null,
      filled: true,
      fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF007BFF)),
      ),
      errorStyle: TextStyle(
        fontSize: 12,
        color: Colors.red[700],
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey[800]),
    );
  }

  void _selecionarValor(String valor) {
    setState(() {
      _valorController.text = valor;
    });
  }

  void _confirmarDoacao() {
    final isDinheiro = _tipoDoacao == "Dinheiro";
    final nome = isDinheiro
        ? formatarNome(_nomeController.text.trim())
        : _tipoDoacao == "Ração"
            ? formatarNome(_nomeRacaoController.text.trim())
            : formatarNome(_nomeAcessoriosController.text.trim());

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente.')),
      );
      return;
    }

    String mensagemPopup = "";
    if (isDinheiro) {
      final valor = _valorController.text.trim();
      historicoDoacoes.add({
        "tipo": "Dinheiro",
        "nome": nome,
        "valor": valor,
      });
    } else {
      historicoDoacoes.add({
        "tipo": _tipoDoacao,
        "nome": nome,
      });
    }

    mensagemPopup =
        "💖 Obrigado pela sua doação!\nSua ajuda transforma a vida de um animal.";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pets, color: Colors.grey, size: 48),
            const SizedBox(height: 16),
            Text("Doação confirmada!",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(mensagemPopup,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14)),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );

    _nomeController.clear();
    _cpfController.clear();
    _valorController.clear();
    _nomeRacaoController.clear();
    _nomeAcessoriosController.clear();
    setState(() {});
  }

  Widget _botaoValor(String valor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _valorController.text == valor;

    return ElevatedButton.icon(
      onPressed: () => _selecionarValor(valor),
      icon: isSelected
          ? const Icon(Icons.check, size: 18, color: Colors.white)
          : const Icon(Icons.attach_money, size: 18, color: Colors.grey),
      label: Text('R\$ $valor'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? const Color(0xFF007BFF)
            : isDark
                ? const Color(0xFF2C2C2C)
                : Colors.grey[200],
        foregroundColor:
            isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: isSelected ? 4 : 1,
      ),
    );
  }

  Widget _buildDetalhes(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final locais = enderecos[_tipoDoacao.trim()] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _tipoDoacao == "Dinheiro"
              ? _nomeController
              : _tipoDoacao == "Ração"
                  ? _nomeRacaoController
                  : _nomeAcessoriosController,
          validator: validarNome,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ÿ\s]')),
          ],
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: estiloCampo("Nome completo", isDark, icon: Icons.person),
        ),
        const SizedBox(height: 16),
        if (_tipoDoacao == "Dinheiro") ...[
          TextFormField(
            controller: _cpfController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) =>
                value == null || value.isEmpty ? 'Informe seu CPF' : null,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration:
                estiloCampo("CPF (para recibo)", isDark, icon: Icons.badge),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _valorController,
            keyboardType: TextInputType.number,
            inputFormatters: [MoneyInputFormatter()],
            validator: (value) => value == null || value.isEmpty
                ? 'Informe o valor da doação'
                : null,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: estiloCampo("Outro valor (R\$)", isDark,
                icon: Icons.attach_money),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ["10", "25", "50", "75"].map(_botaoValor).toList(),
          ),
        ],
        if (_tipoDoacao != "Dinheiro") ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Locais para entrega",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black)),
          ),
          const SizedBox(height: 12),
          ...locais.map((local) {
            final nomeLoja = local["nome"] ?? "";
            final endereco = local["endereco"] ?? "";
            final horario = local["horario"] ?? "";

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Card(
                color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🏪 $nomeLoja",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: isDark ? Colors.white : Colors.black)),
                      const SizedBox(height: 4),
                      Text("📍 $endereco",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color:
                                  isDark ? Colors.white70 : Colors.grey[800])),
                      const SizedBox(height: 2),
                      Text("⏰ $horario",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color:
                                  isDark ? Colors.white60 : Colors.grey[700])),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
        const SizedBox(height: 32),
        Center(
          child: ElevatedButton.icon(
            onPressed: _confirmarDoacao,
            icon: const Icon(Icons.favorite, size: 20),
            label: Text("Confirmar Doação",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
            ),
          ),
        ),

// ⬇️ Histórico de doações logo abaixo do botão
        const SizedBox(height: 32),
        Consumer<DoacaoProvider>(
          builder: (context, provider, _) {
            final doacoes = provider.historico;

            if (doacoes.isEmpty) return const SizedBox();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Histórico de Doações",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                ...doacoes.map((d) {
                  final emoji = d.tipo == "Dinheiro"
                      ? "💰"
                      : d.tipo == "Ração"
                          ? "🥣"
                          : "🧸";

                  return Card(
                    color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading:
                          Text(emoji, style: const TextStyle(fontSize: 24)),
                      title: Text(
                        "${d.tipo} — ${d.valor}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        "${d.data.day.toString().padLeft(2, '0')}/"
                        "${d.data.month.toString().padLeft(2, '0')}/"
                        "${d.data.year}",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: isDark ? Colors.white70 : Colors.grey[700],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),

// ⬅️ Fechamento do método _buildDetalhes
      ],
    );
  }
}
