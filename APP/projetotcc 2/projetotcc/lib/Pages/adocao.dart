import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:projetotcc/Pages/interesse_adocao.dart';

class AdocaoPage extends StatelessWidget {
  const AdocaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.pets, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Pets para Adoção',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A4D8F),
        elevation: 2,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final cards = [
              _buildAnimalCard(context, isMobile,
                  nome: "Jonas",
                  idade: "8 anos",
                  raca: "Bulldog",
                  sexo: "Macho",
                  porte: "Médio",
                  temperamento: "Leal, calmo e companheiro",
                  castrado: true,
                  vermifugado: true,
                  imagemPaths: ['assets/images/Jonasid11.jpg']),
              _buildAnimalCard(context, isMobile,
                  nome: "Vodka",
                  idade: "16 anos",
                  raca: "Bombain",
                  sexo: "Macho",
                  porte: "Pequeno",
                  temperamento: "Brincalhão e afetuoso",
                  castrado: true,
                  vermifugado: true,
                  imagemPaths: ['assets/images/Vodkaid7.jpg']),
              _buildAnimalCard(context, isMobile,
                  nome: "Amora",
                  idade: "12 anos",
                  raca: "Pastor Alemão",
                  sexo: "Fêmea",
                  porte: "Grande",
                  temperamento: "Protetora e dócil com crianças",
                  castrado: true,
                  vermifugado: true,
                  imagemPaths: ['assets/images/Amoraid4.jpg']),
              _buildAnimalCard(context, isMobile,
                  nome: "Pantera",
                  idade: "20 anos",
                  raca: "Siamês",
                  sexo: "Fêmea",
                  porte: "Médio",
                  temperamento: "Tímida no começo, carinhosa depois",
                  castrado: true,
                  vermifugado: false,
                  imagemPaths: ['assets/images/Panteraid6.jpg']),
              _buildAnimalCard(context, isMobile,
                  nome: "Pedrita",
                  idade: "14 anos",
                  raca: "Dachshund",
                  sexo: "Fêmea",
                  porte: "Pequeno",
                  temperamento: "Muito animada e ama colo",
                  castrado: false,
                  vermifugado: true,
                  imagemPaths: ['assets/images/Pedritaid2.jpg']),
              _buildAnimalCard(context, isMobile,
                  nome: "Toby",
                  idade: "8 anos",
                  raca: "Chihuahua",
                  sexo: "Macho",
                  porte: "Mini",
                  temperamento: "Calmo, ama cochilar no sol",
                  castrado: true,
                  vermifugado: true,
                  imagemPaths: ['assets/images/Tobyid2.jpg']),
            ];

            return isMobile
                ? ListView(children: cards)
                : GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: cards,
                  );
          },
        ),
      ),
    );
  }

  Widget _buildAnimalCard(
    BuildContext context,
    bool isMobile, {
    required String nome,
    required String idade,
    required String raca,
    required String sexo,
    required String porte,
    required String temperamento,
    required bool castrado,
    required bool vermifugado,
    required List<String> imagemPaths,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF343A40) : const Color(0xFFDEE2E6);
    final nameColor = isDark ? Colors.white : const Color(0xFF212529);
    final textColor =
        isDark ? const Color(0xFFE0E0E0) : const Color(0xFF495057);
    const nameFontSize = 22.0;
    final buttonPadding = isMobile
        ? const EdgeInsets.symmetric(vertical: 14, horizontal: 20)
        : const EdgeInsets.symmetric(vertical: 18, horizontal: 20);

    return Semantics(
      label: "Adotar $nome, $raca, $sexo, $idade, porte $porte",
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: imagemPaths.first,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit
                          .contain, // ✅ mostra a imagem inteira sem cortar
                      alignment:
                          Alignment.topCenter, // ✅ foca no topo (rosto do pet)
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Icon(
                      sexo.toLowerCase() == "macho" ? Icons.male : Icons.female,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              nome,
              style: GoogleFonts.roboto(
                fontSize: nameFontSize,
                fontWeight: FontWeight.bold,
                color: nameColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(children: [
                  _infoItem(Icons.calendar_today, idade),
                  _infoItem(Icons.pets, raca),
                ]),
                TableRow(children: [
                  _infoItem(Icons.scale, porte),
                  _infoItem(Icons.person, sexo),
                ]),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              temperamento,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 14,
                height: 1.4,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _statusChip("Castrado", castrado),
                _statusChip("Vermifugado", vermifugado),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InteresseAdocaoPage(
                            nomeAnimal: nome,
                            idade: idade,
                            raca: raca,
                            imagemPath: imagemPaths.first,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Você demonstrou interesse em conhecer $nome!',
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                          backgroundColor: const Color(0xFF1A4D8F),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    label: Text(
                      'Adotar $nome',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: buttonPadding,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6C757D)),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF6C757D),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String label, bool ativo) {
    final corTexto = ativo ? Colors.green[800]! : Colors.red[800]!;
    final corFundo = ativo ? Colors.green[50]! : Colors.red[50]!;

    return Chip(
      label: Text(label),
      avatar: Icon(
        ativo ? Icons.check : Icons.close,
        size: 16,
        color: corTexto,
      ),
      backgroundColor: corFundo,
      labelStyle: TextStyle(color: corTexto),
    );
  }
}
