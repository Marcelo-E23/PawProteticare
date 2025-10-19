import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projetotcc/Pages/doacao.dart';
import 'doacao_provider.dart';
import 'doacao_model.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final doacoes = Provider.of<DoacaoProvider>(context).historico;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Histórico de Doações",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF1A4D8F),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: doacoes.isEmpty
            ? Center(
                child: Text(
                  "Nenhuma doação registrada ainda.",
                  style: GoogleFonts.poppins(
                    color: isDark ? Colors.white70 : Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: doacoes.length,
                itemBuilder: (context, index) {
                  final d = doacoes[index];
                  final emoji = d.tipo == "Dinheiro"
                      ? "💰"
                      : d.tipo == "Ração"
                          ? "🥣"
                          : "🧸";

                  return Card(
                    color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Text(
                        emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(
                        "${d.tipo}${" — R\$ ${d.valor}"}",
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
                },
              ),
      ),
    );
  }
}
