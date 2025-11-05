import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../provider/animal_provider.dart';
import 'interesse_adocao.dart';

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

    return ChangeNotifierProvider(
      create: (_) => AnimalProvider()..carregarAnimais(),
      child: Scaffold(
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
        body: Consumer<AnimalProvider>(
          builder: (context, provider, _) {
            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.animais.isEmpty) {
              return Center(
                child: Text(
                  'Nenhum animal disponível para adoção',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              );
            }

            final cards = provider.animais.map((animal) {
              return _buildAnimalCard(context, animal);
            }).toList();

            final isMobile = MediaQuery.of(context).size.width < 600;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: isMobile
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
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimalCard(BuildContext context, dynamic animal) {
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
          // Imagem
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              animal.imagem,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 200,
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF5F5F5),
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
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
                  animal.nome,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${animal.especie} • ${animal.idade} anos',
                  style: GoogleFonts.poppins(color: detailColor),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InteresseAdocaoPage(
                            nomeAnimal: animal.nome,
                            idade: animal.idade.toString(),
                            raca: animal.especie,
                            imagemPath: animal.imagem,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite, size: 18),
                    label: Text(
                      'Adotar ${animal.nome}',
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
}
