import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PatrocinadorCard extends StatefulWidget {
  final Map<String, String> patro;

  const PatrocinadorCard({super.key, required this.patro});

  @override
  State<PatrocinadorCard> createState() => _PatrocinadorCardState();
}

class _PatrocinadorCardState extends State<PatrocinadorCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ÍCONES MAIS SIGNIFICATIVOS
  IconData _iconeParceiro(String nome) {
    if (nome.contains('Caramelo')) return Icons.home;
    if (nome.contains('Ampara')) return Icons.school;
    if (nome.contains('PremieRpet')) return Icons.volunteer_activism;
    return Icons.handshake;
  }

  // DESCRIÇÕES HUMANIZADAS
  String _descricaoReal(String nome) {
    if (nome.contains('Instituto Caramelo')) {
      return 'Abrigo com 300 animais em Ribeirão Pires (SP). Centro cirúrgico 24h, fisioterapia e equipe de 40 profissionais. Necessita de R\$300 mil/mês para operar.';
    } else if (nome.contains('Ampara Animal')) {
      return 'OSCIP focada em advocacy, educação e castração. Não possui abrigo, mas é uma das maiores ONGs do Brasil, reconhecida entre as 100 melhores do país.';
    } else if (nome.contains('PremieRpet')) {
      return 'Marca que apoia eventos de adoção e doações para ONGs, promovendo a causa animal em todo o Brasil.';
    }
    return widget.patro['descricao'] ?? '';
  }

  Future<void> _abrirSite() async {
    final site = widget.patro['site']?.trim();
    if (site != null && site.isNotEmpty && Uri.tryParse(site)?.hasAbsolutePath == true) {
      final uri = Uri.parse(site);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o site')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;

    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    const primaryColor = Color(0xFF0A2E5C);
    const accentColor = Color(0xFF0A84FF);
    final secondaryColor = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4B5563);
    final borderColor = isDark ? const Color(0xFF3A3A3C) : const Color(0xFFD1D5DB);

    final site = widget.patro['site']?.trim();
    final isValidUrl = site != null && site.isNotEmpty;
    final nome = widget.patro['nome'] ?? '';

    // ✅ Caminho da imagem local
    final logoNome = widget.patro['logo'] ?? 'placeholder.png';
    final caminhoLogo = 'assets/images/$logoNome';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: FadeTransition(
        opacity: _fadeIn,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 24 : 16),
              child: Material(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: isValidUrl ? _abrirSite : null,
                  splashColor: accentColor.withOpacity(0.2),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.08),
                          blurRadius: _isHovered ? 12 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Semantics(
                          label: 'Logo da instituição $nome',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              caminhoLogo,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(Icons.pets, size: 28, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _iconeParceiro(nome),
                                    size: 18,
                                    color: accentColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      nome,
                                      style: GoogleFonts.poppins(
                                        fontSize: isWide ? 16 : 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? Colors.white : primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _descricaoReal(nome),
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: secondaryColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Transform.scale(
                                  scale: _isHovered ? 1.03 : 1.0,
                                  child: ElevatedButton.icon(
                                    onPressed: isValidUrl ? _abrirSite : null,
                                    icon: const Icon(Icons.open_in_new, size: 16),
                                    label: Text(
                                      "Visitar site",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1A4D8F),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                      minimumSize: Size(isWide ? 140 : 120, 40),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
