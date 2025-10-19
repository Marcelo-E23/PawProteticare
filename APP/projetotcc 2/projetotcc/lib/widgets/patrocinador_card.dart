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
  final bool _isPressed = false;
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

  IconData _iconeParceiro(String nome) {
    if (nome.contains('Caramelo')) return Icons.favorite;
    if (nome.contains('Ampara')) return Icons.medical_services;
    if (nome.contains('PremieRpet')) return Icons.card_giftcard;
    return Icons.handshake;
  }

  Future<void> _abrirSite() async {
    final site = widget.patro['site'];
    if (site != null && Uri.tryParse(site)?.hasAbsolutePath == true) {
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
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final site = widget.patro['site'];
        final isValidUrl = site != null && site.isNotEmpty;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 24 : 16),
              child: FadeTransition(
                opacity: _fadeIn,
                child: Material(
                  color: theme.brightness == Brightness.dark
                      ? const Color(0xFF1E1E1E)
                      : const Color(0xFFFDFDFD),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: isValidUrl ? _abrirSite : null,
                    splashColor: theme.colorScheme.primary.withOpacity(0.2),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(_isPressed ? 0.15 : 0.08),
                            blurRadius: _isPressed ? 12 : 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Semantics(
                            label:
                                'Logo da instituição ${widget.patro['nome']}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                widget.patro['logo'] ?? '',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[200],
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                                errorBuilder: (context, error, _) => Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.pets,
                                        size: 28, color: Colors.grey),
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
                                        _iconeParceiro(
                                            widget.patro['nome'] ?? ''),
                                        size: 18,
                                        color: const Color(0xFF3A569D)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        widget.patro['nome'] ?? '',
                                        style: GoogleFonts.roboto(
                                          fontSize: isWide ? 18 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.patro['descricao'] ?? '',
                                  style: GoogleFonts.roboto(
                                    fontSize: isWide ? 15 : 14,
                                    color: theme.brightness == Brightness.dark
                                        ? Colors.grey[300]
                                        : Colors.grey[900],
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Semantics(
                                    label:
                                        'Botão para visitar o site de ${widget.patro['nome']}',
                                    child: Tooltip(
                                      message: 'Visitar site da instituição',
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 2,
                                          backgroundColor:
                                              const Color(0xFF1976D2),
                                          foregroundColor: Colors.white,
                                          minimumSize:
                                              Size(isWide ? 180 : 140, 44),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          textStyle: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        icon: const Icon(Icons.open_in_new),
                                        label: const Text("Visitar site"),
                                        onPressed:
                                            isValidUrl ? _abrirSite : null,
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
        );
      },
    );
  }
}
