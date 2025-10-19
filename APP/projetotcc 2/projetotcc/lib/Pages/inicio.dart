import 'package:flutter/material.dart';
import 'package:projetotcc/Pages/fieb.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xfff8f4f4), // Fundo branco total
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Move os textos para o topo
          children: [
            const SizedBox(
                height: 80), // Ajuste a altura para subir ou descer os textos
            Center(
              child: Column(
                children: [
                  const Text(
                    "Paw",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1c045e),
                    ),
                  ),
                  const SizedBox(height: 35), // Espaçamento entre os textos
                  const Text(
                    "Proteticare",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1c045e),
                    ),
                  ),
                  const SizedBox(
                      height: 260), // Maior espaçamento antes do botão
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FiebScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffffff),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: const Text(
                      "FIEB",
                      style: TextStyle(
                        fontSize: 29,
                        fontFamily: 'InknutAntiqua',
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
