import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/doacao_provider.dart';
import '../providers/login_provider.dart';
import '../models/doacao_model.dart';
import '../models/usuario_model.dart';

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

  String _tipoDoacao = "Dinheiro";

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
    _nomeRacaoController.dispose();
    _nomeAcessoriosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loginProvider = Provider.of<LoginProvider>(context);

    // Precisa pedir nome/CPF se primeira doação (nome não está no provider)
    final precisaNomeCpf = loginProvider.nomeUsuario == null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        title: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text("Faça sua Doação",
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
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
                    fontSize: 14, color: isDark ? Colors.white70 : Colors.grey[800]),
              ),
              const SizedBox(height: 16),

              // Tipo de Doação
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("Tipo de Doação",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black)),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _tipoDoacao,
                items: ["Dinheiro", "Ração", "Acessórios"]
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo,
                              style: GoogleFonts.poppins(color: isDark ? Colors.white : Colors.black87)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _tipoDoacao = value!;
                  });
                },
                decoration: estiloCampo("Selecione", isDark, icon: Icons.category_outlined),
              ),
              const SizedBox(height: 24),

              // Nome e CPF (se necessário)
              if (precisaNomeCpf) ...[
                TextFormField(
                  controller: _nomeController,
                  validator: validarNome,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ÿ\s]'))],
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: estiloCampo("Nome completo", isDark, icon: Icons.person),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
                  validator: (value) => value == null || value.isEmpty ? 'Informe seu CPF' : null,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: estiloCampo("CPF", isDark, icon: Icons.badge),
                ),
                const SizedBox(height: 16),
              ],

              // Campos específicos do tipo de doação
              if (_tipoDoacao == "Dinheiro") ...[
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [MoneyInputFormatter()],
                  validator: (value) => value == null || value.isEmpty ? 'Informe o valor da doação' : null,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: estiloCampo("Valor (R\$)", isDark, icon: Icons.attach_money),
                ),
                const SizedBox(height: 16),
              ] else if (_tipoDoacao == "Ração") ...[
                TextFormField(
                  controller: _nomeRacaoController,
                  validator: (value) => value == null || value.isEmpty ? 'Informe o nome da ração' : null,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: estiloCampo("Nome da Ração", isDark, icon: Icons.pets),
                ),
                const SizedBox(height: 16),
              ] else ...[
                TextFormField(
                  controller: _nomeAcessoriosController,
                  validator: (value) => value == null || value.isEmpty ? 'Informe o nome do acessório' : null,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: estiloCampo("Nome do Acessório", isDark, icon: Icons.pets),
                ),
                const SizedBox(height: 16),
              ],

              // Botão enviar
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _confirmarDoacao(loginProvider),
                  icon: const Icon(Icons.favorite, size: 20),
                  label: Text("Confirmar Doação", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007BFF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration estiloCampo(String label, bool isDark, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: isDark ? Colors.white70 : Colors.grey) : null,
      filled: true,
      fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  String? validarNome(String? value) {
    if (value == null || value.trim().isEmpty) return 'Digite seu nome completo';
    final partes = value.trim().split(RegExp(r'\s+'));
    if (partes.length < 2) return 'Digite nome e sobrenome';
    final invalido = partes.any((p) => !RegExp(r'^[A-Za-zÀ-ÿ]+$').hasMatch(p));
    if (invalido) return 'O nome deve conter apenas letras';
    return null;
  }

  void _confirmarDoacao(LoginProvider loginProvider) async {
    if (!_formKey.currentState!.validate()) return;

    // Nome e CPF do formulário
    final nome = _nomeController.text.trim();
    final cpf = _cpfController.text.trim();

    final usuario = UsuarioModel(nome: nome, cpf: cpf);

    final tipo = _tipoDoacao;
    final valor = _valorController.text.trim();
    final itemNome = tipo == "Ração"
        ? _nomeRacaoController.text.trim()
        : tipo == "Acessórios"
            ? _nomeAcessoriosController.text.trim()
            : null;

    final doacao = DoacaoModel(
      tipo: tipo,
      valor: tipo == "Dinheiro" ? double.tryParse(valor.replaceAll(RegExp(r'[^\d.]'), '')) : null,
      usuario: usuario,
      dataDoacao: DateTime.now(),
    );

    try {
      await Provider.of<DoacaoProvider>(context, listen: false)
          .adicionarDoacao(doacao, loginProvider.token!);

      // Salvar nome localmente se primeira doação
      if (loginProvider.nomeUsuario == null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nomeUsuario', nome);
        await prefs.setString('cpfUsuario', cpf);
      }

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
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("💖 Obrigado pela sua doação!\nSua ajuda transforma a vida de um animal.",
                  textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar"),
            ),
          ],
        ),
      );

      _valorController.clear();
      _nomeRacaoController.clear();
      _nomeAcessoriosController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao enviar doação: $e')));
    }
  }
}
