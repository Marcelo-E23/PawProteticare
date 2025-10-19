import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PagamentoPage extends StatefulWidget {
  final String valor;

  const PagamentoPage({super.key, required this.valor});

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  String _metodoSelecionado = "Pix";
  bool _pagamentoConfirmado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pagamento",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6A5AE0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _pagamentoConfirmado
            ? _buildPagamentoConfirmado()
            : _buildFormularioPagamento(),
      ),
    );
  }

  // 🧾 Tela de seleção de método
  Widget _buildFormularioPagamento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Valor da doação:",
          style: GoogleFonts.poppins(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          "R\$ ${widget.valor}",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          "Selecione o método de pagamento:",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        const SizedBox(height: 10),

        // 🟣 Métodos de pagamento
        _metodoButton("Pix"),
        _metodoButton("Cartão"),
        _metodoButton("Dinheiro"),

        const SizedBox(height: 30),

        Center(
          child: ElevatedButton(
            onPressed: _confirmarPagamento,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A5AE0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            ),
            child: Text(
              "Confirmar Pagamento",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🧩 Botão estilizado dos métodos
  Widget _metodoButton(String metodo) {
    final bool selecionado = _metodoSelecionado == metodo;
    return GestureDetector(
      onTap: () => setState(() => _metodoSelecionado = metodo),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selecionado ? const Color(0xFF6A5AE0) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selecionado ? const Color(0xFF6A5AE0) : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: Text(
          metodo,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: selecionado ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // 💰 Tela de pagamento confirmado
  Widget _buildPagamentoConfirmado() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_metodoSelecionado == "Pix") ...[
            Text(
              "Escaneie o QR Code Pix",
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            const SizedBox(height: 20),
            QrImageView(
              data:
                  "pix://doacao?valor=${widget.valor}&beneficiario=PawProtecare",
              version: QrVersions.auto,
              size: 200.0,
            ),
          ] else if (_metodoSelecionado == "Cartão") ...[
            Icon(Icons.credit_card, color: Colors.blue, size: 80),
            const SizedBox(height: 15),
            Text(
              "Pagamento com cartão confirmado!",
              style: GoogleFonts.poppins(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ] else if (_metodoSelecionado == "Dinheiro") ...[
            Icon(Icons.attach_money, color: Colors.green, size: 80),
            const SizedBox(height: 15),
            Text(
              "Pagamento em dinheiro registrado!",
              style: GoogleFonts.poppins(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check_circle_outline),
            label: Text(
              "Concluir",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A5AE0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // 🧠 Lógica de confirmação
  void _confirmarPagamento() {
    setState(() {
      _pagamentoConfirmado = true;
    });
  }
}
