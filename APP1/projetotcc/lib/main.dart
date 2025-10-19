import 'package:flutter/material.dart';
import 'package:projetotcc/Pages/fieb.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projetotcc/theme_provider.dart';
import 'package:projetotcc/login_provider.dart';
import 'package:projetotcc/doacao_provider.dart';
import 'package:projetotcc/historico_page.dart';

import 'package:projetotcc/Pages/cadastro.dart';
import 'package:projetotcc/Pages/sobrenos.dart';

import 'package:projetotcc/Pages/adocao.dart';
import 'package:projetotcc/Pages/doacao.dart';
import 'package:projetotcc/Pages/login.dart';
import 'package:projetotcc/Pages/interesse_adocao.dart';
import 'package:projetotcc/menu_drawer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DoacaoProvider()),
      ],
      child: const Projetotcc(),
    ),
  );
}

class Projetotcc extends StatelessWidget {
  const Projetotcc({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff010d50),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff010d50),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
home: const FiebScreen(), //  Inicia DIRETO no jornal

      routes: {
        '/adocao': (context) => const AdocaoPage(),
        '/doacao': (context) => const DoacaoPage(),
        '/historico': (context) => HistoricoPage(),
        '/FiebScreen': (context) => const FiebScreen(),
      },
    );
  }
}