import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:projetotcc/Pages/adocao.dart';
import 'package:projetotcc/Pages/doacao.dart';

class SobreNosPage extends StatefulWidget {
  const SobreNosPage({super.key});

  @override
  State<SobreNosPage> createState() => _SobreNosPageState();
}

class _SobreNosPageState extends State<SobreNosPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark ? const Color.fromARGB(255, 33, 34, 35) : const Color(0xFFFAFAFA);//fundo geral da tela
    final Color cardColor = isDark ?const Color(0xFF1E1E1E):  Colors.white;//fundo dos cards
    final Color textColor = isDark ? Colors.white : const Color(0xFF333333);//cor principal dos textos
    final Color subtitleColor = isDark ? const Color.fromARGB(255, 212, 212, 212) : const Color.fromARGB(255, 23, 23, 23);//cor de substitulos e textos secun.
    final Color titleColor = isDark ? const Color(0xFF1A4D8F) : const Color(0xFF1A4D8F);//cor dos títulos e AppBar
    final Color dividerColor = isDark ? const Color(0xFF333333) : const Color(0xFFE0E0E0);//cor das linhas divisórias entre seções
    final Color impactoCardColor = isDark ? const Color(0x1A0D47A1) : const Color(0xFFE3F2FD);//fundo especial do cartão “Impacto”

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          
          'Sobre Nós',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: titleColor,
        elevation: 2,
        toolbarHeight: 64,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conheça nossa missão e propósito',
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: subtitleColor),
            ),
            const SizedBox(height: 24),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSection(
                  icon: Icons.info_outline,
                  title: 'Quem somos',
                  content: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(fontSize: 16, height: 1.5, color: textColor),
                      children: const [
                        TextSpan(text: 'A PawProteticare '),
                        TextSpan(text: 'resgata', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ', reabilita e '),
                        TextSpan(text: 'inclui', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' cães e gatos com deficiência física , vítimas de abandono ou maus-tratos — oferecendo acolhimento, cuidado e uma nova chance.'),
                      ],
                    ),
                  ),
                  cardColor: cardColor,
                  titleColor: titleColor,
                   isDark: isDark,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              icon: Icons.favorite_outline,
              title: 'Missão',
              content: Text(
                'Garantir que cada animal com deficiência resgatado receba cuidados médicos, próteses adaptadas e um lar amoroso, com processos transparentes e eficientes.',
                style: GoogleFonts.inter(fontSize: 16, height: 1.6, color: textColor),
                
              ),
              cardColor: cardColor,
              titleColor: titleColor,
               isDark: isDark,
            ),
            const SizedBox(height: 24),
            _buildSection(
              icon: Icons.visibility_outlined,
              title: 'Visão',
              content: Text(
                'Um mundo onde nenhum animal seja excluído por sua condição física.',
                style: GoogleFonts.inter(fontSize: 16, height: 1.6, color: textColor),
              ),
              cardColor: cardColor,
              titleColor: titleColor,
               isDark: isDark,
            ),
            const SizedBox(height: 24),
            _buildSection(
              icon: Icons.star_outline,
              title: 'Valores',
              content: Text(
                'Compromisso • Empatia • Transparência • Responsabilidade',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
              ),
              cardColor: cardColor,
              titleColor: titleColor,
               isDark: isDark,
            ),
            const SizedBox(height: 32),
            _buildImpactoSection(
              title: 'Impacto',
              content: '+200 animais resgatados\n+50 famílias transformadas pela adoção',
              cardColor: impactoCardColor,
              textColor: textColor,
              titleColor: titleColor,
            ),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  Text(
                    'Quer fazer parte dessa mudança?',
                    style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: titleColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Escolha como ajudar',
                    style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: subtitleColor),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pushNamed(context, '/doacao');
                    },
                    child: _buildPrimaryButton(label: 'Conheça os animais'),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pushNamed(context, '/adocao');
                    },
                    child: _buildGhostButton(label: 'Ajude com doações'),
                  ),
                  const SizedBox(height: 32),
                  _buildRodapeEmocional(isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required Widget content,
    required Color cardColor,
    required Color titleColor,
     required bool isDark,
    String? imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
     decoration: BoxDecoration(
  color: cardColor,
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
    if (!isDark)
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
  ],
),


   
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: titleColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600, color: titleColor),
              ),
            ],
          ),
          if (imagePath != null) ...[
            const SizedBox(height: 12),
            Image.asset(imagePath, height: 120),
          ],
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildImpactoSection({
    required String title,
    required String content,
    required Color cardColor,
    required Color textColor,
    required Color titleColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart_outlined, size: 18, color: Color(0xFF1A4D8F)),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.6,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildPrimaryButton({required String label}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        HapticFeedback.lightImpact();
      },
      icon: const Icon(Icons.pets, size: 18, color: Colors.white),
      label: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1A4D8F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        elevation: 3,
        minimumSize: const Size(120, 48),
      ),
    ),
  );
}
Widget _buildGhostButton({required String label}) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton.icon(
      onPressed: () {
        HapticFeedback.lightImpact();
      },
      icon: const Icon(Icons.favorite_border, size: 18, color: Color(0xFF1A4D8F)),
      label: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1A4D8F),
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: const Color(0xFF1A4D8F).withOpacity(0.5), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        minimumSize: const Size(120, 48),
      ),
    ),
  );
}
Widget _buildRodapeEmocional(bool isDark) {
  return Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 32),
    child: Center(
      child: Text(
        '“Cada ação conta. Juntos, fazemos a diferença.”',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF555555),
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
}
