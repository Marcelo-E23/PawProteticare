import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetotcc/Pages/solicitacao_adocao.dart';

const Color primaryColor = Color(0xFF1A4D8F);
const Color backgroundLight = Color(0xFFF9FAFB);
const Color backgroundDark = Color(0xFF121212);
const Color cardLight = Colors.white;
const Color cardDark = Color(0xFF1E1E1E);
const Color statusGreen = Color(0xFF166534);
const Color statusGreenBg = Color(0xFFECFDF5);

class AdocaoPage extends StatelessWidget {
  const AdocaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? backgroundDark : backgroundLight;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.pets, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Pets para Adoção',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final cards = [
              _buildAnimalCard(
                context,
                isMobile,
                "Jonas",
                "8 anos",
                "Bulldog",
                "Macho",
                "Médio",
                true,
                true,
                'assets/images/Jonasid11.png',
              ),
              _buildAnimalCard(
                context,
                isMobile,
                "Vodka",
                "16 anos",
                "Bombaim",
                "Macho",
                "Pequeno",
                true,
                true,
                'assets/images/Vodkaid7.jpg',
              ),
              _buildAnimalCard(
                context,
                isMobile,
                "Amora",
                "12 anos",
                "Pastor Alemão",
                "Fêmea",
                "Grande",
                true,
                true,
                'assets/images/Amoraid4.jpg',
              ),
              _buildAnimalCard(
                context,
                isMobile,
                "Pantera",
                "20 anos",
                "Siamês",
                "Fêmea",
                "Médio",
                true,
                false,
                'assets/images/Panteraid6.jpg',
              ),
              _buildAnimalCard(
                context,
                isMobile,
                "Pedrita",
                "14 anos",
                "Dachshund",
                "Fêmea",
                "Pequeno",
                true,
                true,
                'assets/images/Pedritaid2.jpg',
              ),
              _buildAnimalCard(
                context,
                isMobile,
                "Toby",
                "8 anos",
                "Chihuahua",
                "Macho",
                "Mini",
                true,
                true,
                'assets/images/Tobyid2.jpg',
              ),
            ];

            return isMobile
                ? ListView.separated(
                    itemCount: cards.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, i) => cards[i],
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                    children: cards,
                  );
          },
        ),
      ),
    );
  }

  Widget _buildAnimalCard(
    BuildContext context,
    bool isMobile,
    String nome,
    String idade,
    String raca,
    String sexo,
    String porte,
    bool castrado,
    bool vermifugado,
    String imagemPath,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? cardDark : cardLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0A2E5C);
    final detailColor = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4B5563);
    final borderColor = isDark ? const Color(0xFF3A3A3C) : const Color(0xFFD1D5DB);

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👇 IMAGEM CORRIGIDA — SEM CORTES, FOCO NO ROSTO
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                imagemPath,
                height: isMobile ? 200 : 240,
                width: double.infinity,
                fit: BoxFit.fitWidth, // ✅ MOSTRA TODO O ANIMAL
                alignment: Alignment.topCenter, // ✅ FOCO NO ROSTO
                errorBuilder: (_, __, ___) => Container(
                  height: isMobile ? 200 : 240,
                  color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF5F5F5),
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _infoItem(Icons.cake, idade, detailColor),
                    const SizedBox(width: 16),
                    _infoItem(Icons.pets, raca, detailColor),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _infoItem(sexo == 'Macho' ? Icons.male : Icons.female, sexo, detailColor),
                    const SizedBox(width: 16),
                    _infoItem(Icons.scale, porte, detailColor),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _statusChip("Castrado", castrado),
                    _statusChip("Vermifugado", vermifugado),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Você demonstrou interesse em conhecer $nome!',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          backgroundColor: primaryColor,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InteresseAdocaoPage(
                            nomeAnimal: nome,
                            idade: idade,
                            raca: raca,
                            imagemPath: imagemPath,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite, size: 18),
                    label: Text(
                      'Adotar $nome',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _statusChip(String label, bool ativo) {
    final corTexto = ativo ? statusGreen : const Color(0xFFB91C1C);
    final corFundo = ativo ? statusGreenBg : const Color(0xFFFFF1F1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            ativo ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: corTexto,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: corTexto,
            ),
          ),
        ],
      ),
    );
  }
}