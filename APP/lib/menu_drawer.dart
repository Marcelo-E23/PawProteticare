import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projetotcc/Pages/tela_inicial.dart';
import 'package:projetotcc/Pages/sobre_nos.dart';
import 'package:projetotcc/theme_provider.dart';
import 'package:projetotcc/login_provider.dart';
import 'package:projetotcc/Pages/doacao.dart';
import 'package:projetotcc/Pages/login.dart';
import 'package:projetotcc/Pages/adocao.dart';
import 'package:projetotcc/historico_page.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final userName = loginProvider.nomeUsuario ?? "Visitante";
    final screenWidth = MediaQuery.of(context).size.width;

    final drawerContent = Material(
      elevation: 4,
      color: isDarkMode ? const Color(0xFF1C1C1E) : const Color(0xFFF9FAFB),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 28),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFF0D47A1)
                  : const Color((0xFF1A4D8F)),
            ),
            child: Row(
              children: [
                Semantics(
                  label: 'Logo da ONG',
                  child: CircleAvatar(
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
          _criarBlocoTitulo(context, 'ONG'),
          _criarItemMenu(
            context,
            'Tela Inicial',
            Icons.home_filled,
            FiebScreen(),
            // exigeLogin: true,
            // estaLogado: loginProvider.estaLogado,
          ),
          _criarItemMenu(
            context,
            'Adoção',
            Icons.pets_outlined,
            AdocaoPage(),
            // exigeLogin: true,
            // estaLogado: loginProvider.estaLogado,
          ),
          _criarItemMenu(
            context,
            'Doação',
            Icons.volunteer_activism_outlined,
            DoacaoPage(),
            // exigeLogin: true,
            // estaLogado: loginProvider.estaLogado,
          ),
          _criarItemMenu(
            context,
            'Sobre Nós',
            Icons.business,
            SobreNosPage(),
            //exigeLogin: true,
            //estaLogado: loginProvider.estaLogado,
          ),
          _criarSeparador(context),
          _criarBlocoTitulo(context, 'USUÁRIO'),
          _criarItemMenu(
            context,
            'Minhas Adoções',
            Icons.history_outlined,
            HistoricoPage(),
            //exigeLogin: true,
            // estaLogado: loginProvider.estaLogado,
          ),
          _criarItemMenu(context, 'Minha Conta', Icons.person_outline, Login()),
          _criarSeparador(context),
          _criarBlocoTitulo(context, 'CONFIGURAÇÕES'),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return _criarItemMenu(
                context,
                'Modo noturno',
                themeProvider.isDarkMode
                    ? Icons.nightlight_round
                    : Icons.wb_sunny,
                Login(), // não navega, apenas exibe
                textoColor: isDarkMode
                    ? const Color(0xFFE0E0E0)
                    : const Color(0xFF212121),
                trailing: Switch.adaptive(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
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
            Login(),
            textoColor: const Color(0xFFE53935),
            offset: const Offset(4, -1), // 👈 ajuste vertical do ícone
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
                content:
                    Text('Você precisa estar logado para acessar essa área.'),
                backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => pagina,
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        },
        splashColor: isDarkMode ? Colors.white10 : Colors.blue[50],
        highlightColor: const Color(0x331976D2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Transform.translate(
                offset: offset,
                child: Icon(
                  icone,
                  color: textoColor == const Color(0xFFE53935)
                      ? textoColor
                      : isDarkMode
                          ? const Color(0xFF4C8DFF)
                          : const Color(0xFF1976D2),
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
                        (isDarkMode
                            ? const Color(0xFFE0E0E0)
                            : const Color(0xFF212121)),
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
          color: isDarkMode
              ? Colors.white.withOpacity(0.75)
              : Colors.black.withOpacity(0.75),
        ),
      ),
    );
  }

  Widget _criarSeparador(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      color: isDarkMode
          ? const Color.fromRGBO(255, 255, 255, 0.08)
          : const Color(0xFFE0E0E0),
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
