import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SobreNosPage extends StatelessWidget {
  const SobreNosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor =
        isDark ? const Color(0xff262a2e) : Colors.white; // Azul petróleo
    final Color cardColor = isDark
        ? const Color(0xffc8ced2)
        : const Color(0xFFF8F9FA); // Cinza azulado
    final Color textColor = isDark
        ? const Color(0xFFE0E0E0)
        : const Color(0xFF212121); // Cinza claro
    final Color titleColor = isDark
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF000000); // Branco puro
    final Color subtitleColor = isDark
        ? const Color(0xffd1d5d5)
        : const Color(0xFF333333); // Cinza médio
    final Color buttonPrimary = isDark
        ? const Color(0xFF64B5F6)
        : const Color(0xFF1976D2); // Azul suave
    final Color buttonSecondary =
        isDark ? const Color(0xFF64B5F6) : const Color(0xFF1976D2);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Sobre Nós',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: buttonPrimary,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: largura > 600 ? 600 : double.infinity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/marrom.jpg',
                        width: double.infinity,
                        height: largura < 400 ? 160 : 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: largura < 400 ? 160 : 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Cada adoção transforma uma vida.',
                          style: GoogleFonts.montserrat(
                            fontSize: largura < 400 ? 16 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: const [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildSectionTitle(
                    'Sobre o projeto', Icons.info, buttonPrimary, titleColor),
                const SizedBox(height: 16),
                _buildAnimatedCard(
                  context,
                  content:
                      'Este projeto acadêmico demonstra como a tecnologia pode transformar vidas, apoiando o resgate e a adoção de animais com deficiência.',
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(
                    'Nossa missão', Icons.flag, buttonPrimary, titleColor),
                const SizedBox(height: 16),
                _buildAnimatedCard(
                  context,
                  content:
                      'Criar soluções acessíveis e funcionais para causas sociais, promovendo inclusão e responsabilidade.',
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, color: buttonPrimary, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Por que este projeto importa',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildAnimatedCard(
                  context,
                  content:
                      'Animais com deficiência são frequentemente esquecidos em abrigos. Este app facilita a conexão entre esses animais e pessoas dispostas a oferecer um lar acolhedor e responsável.',
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(
                    'Conheça o Marrom', Icons.pets, buttonPrimary, titleColor),
                const SizedBox(height: 16),
                _buildAnimatedCard(
                  context,
                  content:
                      'Marrom é um vira-lata que ficou paraplégico após um atropelamento na rodovia Raposo Tavares. Com o tempo, passou a precisar de atenção especial — e foi aí que a voluntária Sophia Porto o levou para casa.',
                  textColor: textColor,
                ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Explore o app',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: buttonPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Navegue pelas principais funcionalidades',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 500;
                    return isWide
                        ? Row(
                            children: [
                              Expanded(
                                child: _buildPrimaryButton(
                                  context,
                                  icon: Icons.pets,
                                  label: 'Conheça nossa história',
                                  route: '/adocao',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildSecondaryButton(
                                  context,
                                  icon: Icons.volunteer_activism_outlined,
                                  label: 'Ajude com doações',
                                  route: '/doacao',
                                  showFeedback: true,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _buildPrimaryButton(
                                context,
                                icon: Icons.pets,
                                label: 'Conheça nossos animais',
                                route: '/adocao',
                              ),
                              const SizedBox(height: 16),
                              _buildSecondaryButton(
                                context,
                                icon: Icons.volunteer_activism_outlined,
                                label: 'Ajude com doações',
                                route: '/doacao',
                                showFeedback: true,
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    'Juntos, podemos mudar o futuro dos animais com deficiência.\nSeja parte dessa transformação.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: subtitleColor,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
  }) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 150),
      child: Semantics(
        label: label,
        button: true,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, route),
            icon: Icon(icon, size: 24, color: Colors.white),
            label: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF64B5F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              elevation: 2,
              shadowColor: Colors.white.withOpacity(0.05),
            ).copyWith(
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color(0xFFDDE5FF);
                }
                return const Color(0xFFE0E7FF);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    bool showFeedback = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color buttonSecondary =
        isDark ? const Color(0xFF64B5F6) : const Color(0xFF1976D2);

    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 150),
      child: Semantics(
        label: label,
        button: true,
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, route);
              if (showFeedback) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Obrigado por apoiar essa causa! 💙',
                      style: GoogleFonts.roboto(fontSize: 14),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: Icon(icon, size: 24, color: buttonSecondary),
            label: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: buttonSecondary,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: buttonSecondary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            ).copyWith(
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color(0xFFDDE5FF);
                }
                return const Color(0xFFE0E7FF);
              }),
              shadowColor: MaterialStateProperty.all<Color>(
                Colors.black.withOpacity(0.05),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
      String title, IconData icon, Color iconColor, Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedCard(
    BuildContext context, {
    required String content,
    required Color textColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark
        ? const Color(0xFFE0E4E7) // fundo suave no modo escuro
        : const Color(0xFFF8F9FA); // fundo claro no modo claro

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 600),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: isDark ? Colors.transparent : const Color(0xFFE0E0E0)),
        ),
        color: cardColor,
        shadowColor: Colors.black.withOpacity(0.05),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              content,
              style: GoogleFonts.roboto(
                fontSize: 15,
                height: 1.8,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
