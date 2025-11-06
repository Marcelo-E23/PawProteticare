import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiaCard extends StatefulWidget {
  final Map<String, String> noticia;

  const NoticiaCard({super.key, required this.noticia});

  @override
  State<NoticiaCard> createState() => _NoticiaCardState();
}

class _NoticiaCardState extends State<NoticiaCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  bool _isHovered = false;

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

  IconData _categoriaIcon(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'campanha':
        return Icons.volunteer_activism;
      case 'história':
        return Icons.pets;
      case 'pesquisa':
        return Icons.science;
      default:
        return Icons.pets;
    }
  }

  String _resumoNoticia(String titulo) {
    if (titulo.contains('Adoção como ato de justiça social')) {
      return 'Chiquinho, cão cego resgatado em Betim, esperou 16 meses por um lar até encontrar uma família que o ama incondicionalmente.';
    } else if (titulo.contains('Atena: pitbull resgatada')) {
      return 'Atena, resgatada com medo e desnutrida, hoje é o centro das atenções de seu lar em Marília, vivendo com dignidade e amor.';
    } else if (titulo.contains('Mapa do abandono')) {
      return 'Estudo revela que 80% dos pets nos lares brasileiros foram adotados, mas mais de 30 milhões ainda vivem nas ruas.';
    }
    return titulo;
  }

  String _localizacao(String titulo) {
    if (titulo.contains('Adoção como ato de justiça social')) {
      return 'Betim, MG';
    } else if (titulo.contains('Atena: pitbull resgatada')) {
      return 'Marília, SP';
    } else if (titulo.contains('Mapa do abandono')) {
      return 'Brasil';
    }
    return 'São Paulo, SP';
  }

  Future<void> _abrirLink() async {
    final url = widget.noticia['url']?.trim();
    if (url != null &&
        url.isNotEmpty &&
        Uri.tryParse(url)?.hasAbsolutePath == true) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o link')),
        );
      }
    }
  }

  // ✅ Função para carregar imagem da web ou local automaticamente
  Widget _buildImagem(String imagem, bool isDark) {
    if (imagem.startsWith('http')) {
      // Se for uma URL da internet
      return Image.network(
        imagem,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 160,
          color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF5F5F5),
          child: const Center(
            child: Icon(Icons.image_not_supported,
                size: 48, color: Colors.grey),
          ),
        ),
      );
    }

    // Caso contrário, tenta carregar do assets
    return Image.asset(
      'assets/images/$imagem',
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: 160,
        color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF5F5F5),
        child: const Center(
          child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width > 800;

    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    const primaryColor = Color(0xFF0A2E5C);
    const accentColor = Color(0xFF0A84FF);
    final secondaryColor =
        isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4B5563);
    final borderColor =
        isDark ? const Color(0xFF3A3A3C) : const Color(0xFFD1D5DB);

    final titulo = widget.noticia['titulo'] ?? '';
    final data = widget.noticia['data'] ?? '';
    final categoria = widget.noticia['categoria'] ?? '';
    final imagem = widget.noticia['imagem']?.trim() ?? 'placeholder.png';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: FadeTransition(
        opacity: _fadeIn,
        child: Material(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _abrirLink,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    label: 'Imagem da notícia',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImagem(imagem, isDark), // ✅ Aqui usamos a função
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _categoriaIcon(categoria),
                          size: 16,
                          color: accentColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          categoria,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$data • ${_localizacao(titulo)}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: secondaryColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _resumoNoticia(titulo),
                    style: GoogleFonts.poppins(
                      fontSize: isWide ? 16 : 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Transform.scale(
                      scale: _isHovered ? 1.03 : 1.0,
                      child: ElevatedButton.icon(
                        onPressed: _abrirLink,
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: Text(
                          "Acessar notícia",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A4D8F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
