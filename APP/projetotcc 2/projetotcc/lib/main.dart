import 'package:flutter/material.dart';
import 'package:projetotcc/Pages/minhas_doacoes.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projetotcc/providers/theme_provider.dart';
import 'package:projetotcc/providers/login_provider.dart';
import 'package:projetotcc/providers/doacao_provider.dart';

import 'package:projetotcc/Pages/inicio.dart';
import 'package:projetotcc/Pages/recuperar_senha.dart';
import 'package:projetotcc/Pages/adocao.dart';
import 'package:projetotcc/Pages/doacao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Instancia manualmente para carregar o login salvo
  final loginProvider = LoginProvider();
  await loginProvider.carregarLoginSalvo();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: loginProvider),
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
    final loginProvider = Provider.of<LoginProvider>(context);

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

      // 🔹 Se estiver logado, vai pra tela inicial direto
      home: loginProvider.estaLogado
          ? const TelaPrincipal()
          : const SplashDelay(),
      routes: {
        '/adocao': (context) => const AdocaoPage(),
        '/doacao': (context) => const DoacaoPage(),
        '/recuperar': (context) => const RecuperarSenhaPage(),
        '/historico': (context) => const HistoricoUsuarioPage(),
      },
    );
  }
}

class SplashDelay extends StatefulWidget {
  const SplashDelay({super.key});

  @override
  State<SplashDelay> createState() => _SplashDelayState();
}

class _SplashDelayState extends State<SplashDelay> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const TelaPrincipal(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f4f4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo1.png', width: 120),
            const SizedBox(height: 20),
            const Text(
              'Paw Proteticare',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color(0xff1c045e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
