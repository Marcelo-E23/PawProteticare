import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Pages/fieb.dart';
import 'Pages/sobrenos.dart';
import 'theme_provider.dart';
import 'provider/login_provider.dart';
import 'Pages/doacao.dart';
import 'Pages/adocao.dart';
import 'Pages/historico_page.dart';
import 'Pages/login.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final userName = loginProvider.nomeUsuario ?? "Visitante";
    final screenWidth = MediaQuery.of(context).size.width;

    final drawerContent = Material(
      elevation: 4,
      color: isDarkMode ? const Color(0xFF1C1C1E) : const Color(0xFFF9FAFB),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Cabeçalho
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 28),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF0D47A1) : const Color(0xFF1A4D8F),
            ),
            child: Row(
              children: [
                Semantics(
                  label: 'Logo da ONG',
                  child: const CircleAvatar(
                    radius: 43,
                    backgroundImage: AssetImage('assets/images/logo1.png'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, $userName',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Bem-vindo ao Paw Proteticare',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),

          // Blocos do menu
          _criarBlocoTitulo(context, 'ONG'),
          _criarItemMenu(context, 'Tela Inicial', Icons.home_filled, const FiebScreen()),
          _criarItemMenu(context, 'Adoção', Icons.pets_outlined, const AdocaoPage(), exigeLogin: true, estaLogado: loginProvider.estaLogado),
          _criarItemMenu(context, 'Doação', Icons.volunteer_activism_outlined, const DoacaoPage(), exigeLogin: true, estaLogado: loginProvider.estaLogado),
          _criarItemMenu(context, 'Sobre Nós', Icons.business, const SobreNosPage()),
          _criarSeparador(context),
          _criarBlocoTitulo(context, 'USUÁRIO'),
          _criarItemMenu(context, 'Minhas Adoções', Icons.history_outlined, const HistoricoUsuarioPage(), exigeLogin: true, estaLogado: loginProvider.estaLogado),
          _criarItemMenu(context, 'Minha Conta', Icons.person_outline, const Login()),
          _criarSeparador(context),
          _criarBlocoTitulo(context, 'CONFIGURAÇÕES'),

          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return _criarItemMenu(
                context,
                'Modo noturno',
                themeProvider.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                const Login(), // apenas visual, não navega
                textoColor: isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF212121),
                trailing: Switch.adaptive(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(value),
                  activeColor: const Color(0xFF4C8DFF),
                  inactiveTrackColor: Colors.grey[300],
                ),
              );
            },
          ),
          const SizedBox(height: 10),

          _criarItemMenu(
            context,
            'Sair',
            Icons.logout,
            const Login(),
            textoColor: const Color(0xFFE53935),
            offset: const Offset(4, -1),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );

    if (screenWidth >= 900) {
      return SizedBox(width: 320, child: drawerContent);
    }

    return AnimatedTheme(
      data: Theme.of(context),
      duration: const Duration(milliseconds: 300),
      child: Drawer(
        width: screenWidth * 0.85,
        child: SafeArea(child: drawerContent),
      ),
    );
  }

  // ------------------- Funções auxiliares -------------------
  Widget _criarItemMenu(
    BuildContext context,
    String titulo,
    IconData icone,
    Widget pagina, {
    bool exigeLogin = false,
    bool estaLogado = true,
    Color? textoColor,
    Widget? trailing,
    Offset offset = Offset.zero,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      label: titulo,
      button: true,
      child: InkWell(
        onTap: () {
          if (exigeLogin && !estaLogado) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Você precisa estar logado para acessar essa área.'),
                backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => pagina,
              transitionsBuilder: (_, animation, __, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          );
        },
        splashColor: isDarkMode ? Colors.white10 : Colors.blue[50],
        highlightColor: const Color(0x331976D2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Transform.translate(
                offset: offset,
                child: Icon(
                  icone,
                  color: textoColor ??
                      (isDarkMode ? const Color(0xFF4C8DFF) : const Color(0xFF1976D2)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  titulo,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: textoColor ??
                        (isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF212121)),
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _criarBlocoTitulo(BuildContext context, String titulo) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Text(
        titulo.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white.withOpacity(0.75) : Colors.black.withOpacity(0.75),
        ),
      ),
    );
  }

  Widget _criarSeparador(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      color: isDarkMode ? const Color.fromRGBO(255, 255, 255, 0.08) : const Color(0xFFE0E0E0),
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
