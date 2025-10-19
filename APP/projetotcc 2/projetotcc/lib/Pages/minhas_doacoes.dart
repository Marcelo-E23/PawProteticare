import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/doacao_provider.dart';
import '../providers/login_provider.dart';

class HistoricoUsuarioPage extends StatelessWidget {
  const HistoricoUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;

    if (token == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff5668cf),
          centerTitle: true,
          title: Text(
            "Meu Histórico de Doações",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        body: Center(
          child: Text(
            "Você precisa estar logado para ver seu histórico.",
            style: GoogleFonts.poppins(
              color: isDark ? Colors.white70 : Colors.grey[800],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Carrega doações assim que o widget é construído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoacaoProvider>(context, listen: false)
          .carregarDoacoesUsuario(token);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5668cf),
        centerTitle: true,
        title: Text(
          "Meu Histórico de Doações",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Consumer<DoacaoProvider>(
        builder: (context, provider, _) {
          final doacoes = provider.historicoUsuario;

          if (doacoes.isEmpty) {
            return Center(
              child: Text(
                "Você ainda não realizou nenhuma doação.",
                style: GoogleFonts.poppins(
                  color: isDark ? Colors.white70 : Colors.grey[800],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: doacoes.length,
            itemBuilder: (context, index) =>
                _buildDoacaoTile(doacoes[index], isDark),
          );
        },
      ),
    );
  }

  Widget _buildDoacaoTile(doacao, bool isDark) {
    final emoji = doacao.tipo == "Dinheiro"
        ? "💰"
        : doacao.tipo == "Ração"
            ? "🥣"
            : "🧸";

    final valorTexto = doacao.tipo == "Dinheiro"
        ? " — R\$ ${doacao.valor?.toStringAsFixed(2) ?? 0}"
        : doacao.itemNome != null
            ? " — ${doacao.itemNome}"
            : "";

    final dataFormatada =
        "${doacao.dataDoacao.day.toString().padLeft(2, '0')}/"
        "${doacao.dataDoacao.month.toString().padLeft(2, '0')}/"
        "${doacao.dataDoacao.year}";

    return Card(
      color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 24)),
        title: Text(
          "${doacao.tipo}$valorTexto",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          dataFormatada,
          style: GoogleFonts.poppins(
              fontSize: 13, color: isDark ? Colors.white70 : Colors.grey[700]),
        ),
      ),
    );
  }
}
