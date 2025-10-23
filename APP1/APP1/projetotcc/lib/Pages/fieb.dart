import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetotcc/menu_drawer.dart';
import 'package:projetotcc/widgets/noticia_card.dart';
import 'package:projetotcc/widgets/patrocinador_card.dart';
import 'package:projetotcc/Pages/cadastro.dart';

class FiebScreen extends StatefulWidget {
  const FiebScreen({super.key});

  @override
  State<FiebScreen> createState() => _FiebScreenState();
}

class _FiebScreenState extends State<FiebScreen> {
  int _noticiasExibidas = 2;

  final List<Map<String, String>> noticias = const [
    {
      'titulo':
          'Adoção como ato de justiça social:\nquando a fé se une ao resgate animal',
      'url':
          'https://www.otempobetim.com.br/cidades/2025/2/21/animais-deficientes-enfrentam-uma-longa-jornada-ate-a-adocao',
      'imagem':
          'https://www.otempobetim.com.br/adobe/dynamicmedia/deliver/dm-aid--d9a51e1b-01c1-4e09-bacd-a1a27ec20d86/cidades---betim-betim-ado--o-animal-pets-1740091308.png?quality=90&width=1200&preferwebp=true',
      'data': 'Publicado em 21/02/2025',
      'categoria': 'Campanha'
    },
    {
      'titulo':
          'Atena: pitbull resgatada vira símbolo de resistência e superação',
      'url':
          'https://g1.globo.com/sp/sorocaba-jundiai/tem-mais-pet/noticia/2025/01/16/adocao-responsavel-garante-vida-digna-a-animais-vitimas-de-maus-tratos-e-abandono-no-interior-de-sp.ghtml',
      'imagem':
          'https://s2-g1.glbimg.com/XLFWXNOGM2Mm8HxJ4yp06NXAw9E=/0x0:1200x800/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2025/8/f/d66tY4SdyiPM19S0cdbQ/design-sem-nome-3-.jpg',
      'data': 'Publicado em 16/01/2025',
      'categoria': 'História'
    },
    {
      'titulo': 'Mapa do abandono: os 5 bairros mais críticos do RJ',
      'url':
          'https://www.cnnbrasil.com.br/nacional/sudeste/sp/80-dos-pets-nos-lares-brasileiros-foram-adotados-indica-pesquisa/',
      'imagem':
          'https://admin.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/04/CRISTO_ABRACO_FECHADO_01_HORIZONTAL.png?w=849&h=477&crop=0',
      'data': 'Publicado em 23/06/2025',
      'categoria': 'Pesquisa'
    },
  ];

  final List<Map<String, String>> patrocinadores = const [
    {
      'nome': 'Instituto Caramelo',
      'descricao': 'Resgate e reabilitação de animais vítimas de maus-tratos.',
      'logo': 'https://institutocaramelo.org/logo.png',
      'site': 'https://institutocaramelo.org'
    },
    {
      'nome': 'Ampara Animal',
      'descricao':
          'ONG que sustenta mais de 450 abrigos em meio à crise de abandono animal.',
      'logo': 'https://amparanimal.org.br/logo.png',
      'site': 'https://amparanimal.org.br'
    },
    {
      'nome': 'PremieRpet',
      'descricao': 'Marca que promove eventos de adoção e doações para ONGs.',
      'logo': 'https://www.premierpet.com.br/assets/img/logo.png',
      'site': 'https://www.premierpet.com.br'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width > 800;

    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB);
    final primaryColor = isDark ? Colors.white : const Color(0xFF0A2E5C);
    final secondaryColor = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4B5563);
    const accentColor = Color(0xFF0A84FF);
    final dividerColor = isDark ? const Color(0xFF3A3A3C) : const Color(0xFFD1D5DB);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1A4D8F),
        foregroundColor: Colors.white,
        title: Text(
          "Paw Proteticare",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => Tooltip(
              message: 'Abrir menu',
              child: IconButton(
                icon: const Icon(Icons.menu, size: 24),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ),
        ],
      ),
      endDrawer: MenuDrawer(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 24 : 16,
              vertical: 24,
            ),
            children: [
              // 👇 SEÇÃO: MOVIMENTO PELA INCLUSÃO ANIMAL
              Text(
                'Movimento pela Inclusão Animal',
                style: GoogleFonts.poppins(
                  fontSize: isWide ? 24 : 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: dividerColor, thickness: 1),
              const SizedBox(height: 16),
              Text(
                'Mais de 30 milhões de animais vivem nas ruas do Brasil. Nossa missão é transformar vidas através da reabilitação, próteses e adoção consciente — porque todos merecem uma segunda chance.',
                style: GoogleFonts.poppins(
                  fontSize: isWide ? 16 : 14,
                  color: secondaryColor,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 48),

              // 👇 NOTÍCIAS
              Text(
                'Histórias Reais de Transformação',
                style: GoogleFonts.poppins(
                  fontSize: isWide ? 20 : 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: dividerColor, thickness: 1),
              const SizedBox(height: 16),
              Text(
                'Conheça casos reais de resgate, reabilitação e adoção que inspiram nossa luta diária.',
                style: GoogleFonts.poppins(
                  fontSize: isWide ? 16 : 14,
                  color: secondaryColor,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              ...noticias.take(_noticiasExibidas).map((noticia) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: NoticiaCard(noticia: noticia),
                  )),
              if (_noticiasExibidas < noticias.length)
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A4D8F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      setState(() {
                        _noticiasExibidas += 1;
                      });
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(
                      "Carregar Mais",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              const SizedBox(height: 48),

              // 👇 PARCEIROS
              Text(
                'Parceiros que Sustentam Esta Missão',
                style: GoogleFonts.poppins(
                  fontSize: isWide ? 20 : 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: dividerColor, thickness: 1),
              const SizedBox(height: 16),
              Text(
                'Instituições que acreditam no nosso propósito e apoiam nossos projetos de reabilitação e adoção.',
                style: GoogleFonts.poppins(
                  fontSize: isWide ? 16 : 14,
                  color: secondaryColor,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              ...patrocinadores.map((patro) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: PatrocinadorCard(patro: patro),
                  )),

              const SizedBox(height: 48),

              // 👇 CALL-TO-ACTION EMOCIONAL
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: dividerColor),
                ),
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: accentColor, size: 32),
                    const SizedBox(height: 16),
                    Text(
                      'Quer fazer parte dessa mudança?',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Crie sua conta e ajude animais com deficiência a encontrarem um lar cheio de amor.',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: secondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A4D8F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Cadastro()),
                        );
                      },
                      child: Text(
                        'Criar conta',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // 👇 RODAPÉ
              Divider(color: dividerColor),
              const SizedBox(height: 16),
              Text(
                '© Paw Proteticare 2025 — Tecnologia com propósito para animais com deficiência 💙',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: secondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}