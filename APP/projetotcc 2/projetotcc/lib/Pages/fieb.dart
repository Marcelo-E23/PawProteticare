import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projetotcc/menu_drawer.dart';
import 'package:projetotcc/widgets/noticia_card.dart';
import 'package:projetotcc/widgets/patrocinador_card.dart';

class FiebScreen extends StatelessWidget {
  const FiebScreen({super.key});

  // 🔹 Sugestão: mover esses dados para arquivos separados como noticias_data.dart e patrocinadores_data.dart
  final List<Map<String, String>> noticias = const [
    {
      'titulo':
          'Adoção como ato de justiça social:\nquando a fé se une ao resgate animal',
      'url':
          'https://www.metropoles.com/colunas/e-o-bicho/mulheres-lideram-adocao-responsavel-no-brasil',
      'imagem':
          'https://uploads.metroimg.com/wp-content/uploads/2019/08/19184416/e%CC%81obicho-cachorro.png',
      'data': 'Publicado em 04/04/2025',
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Paw Proteicare",
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        actions: [
          Builder(
            builder: (context) => Tooltip(
              message: 'Abrir menu',
              child: IconButton(
                icon: const Icon(Icons.menu, size: 32),
                padding: const EdgeInsets.all(12),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ),
        ],
      ),
      endDrawer: MenuDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 24 : 16, vertical: 24),
                children: [
                  Semantics(
                    label: 'Título da seção de histórias',
                    child: Text(
                      'Histórias que transformam vidas',
                      style: GoogleFonts.roboto(
                        fontSize: isWide ? 26 : 22,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    label: 'Descrição da seção de histórias',
                    child: Text(
                      'Relatos de resgate, cura e esperança.',
                      style: GoogleFonts.roboto(
                        fontSize: isWide ? 18 : 14,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey[300]
                            : Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...noticias.map((noticia) => AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: 1,
                        child: NoticiaCard(noticia: noticia),
                      )),
                  const Divider(
                      height: 32, thickness: 1, color: Color(0xFFE0E0E0)),
                  const SizedBox(height: 8),
                  Semantics(
                    label: 'Título da seção de instituições',
                    child: Text(
                      'Instituições que fazem a diferença.',
                      style: GoogleFonts.roboto(
                        fontSize: isWide ? 22 : 18,
                        fontWeight: FontWeight.bold,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Semantics(
                    label: 'Descrição da seção de instituições',
                    child: Text(
                      'Conheça as instituições que sustentam essa missão.',
                      style: GoogleFonts.roboto(
                        fontSize: isWide ? 18 : 14,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey[300]
                            : Colors.grey[800],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...patrocinadores.map((patro) => AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: 1,
                        child: PatrocinadorCard(patro: patro),
                      )),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
