import 'package:projetotcc/models/usuario_model.dart';

class DoacaoModel {
  final int? id; // id gerado pelo banco
  final String tipo;
  final double? valor;
  final UsuarioModel usuario;
  final DateTime dataDoacao;

  DoacaoModel({
    this.id,
    required this.tipo,
    this.valor,
    required this.usuario,
    required this.dataDoacao,
  });

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'tipodoacao': tipo,
        'valor': valor != null ? valor.toString() : null,
        'doador': usuario.toJson(),
        'datadoacao': dataDoacao.toIso8601String(),
      };

  factory DoacaoModel.fromJson(Map<String, dynamic> json) => DoacaoModel(
        id: json['id'],
        tipo: json['tipodoacao'],
        valor: json['valor'] != null ? double.tryParse(json['valor'].toString()) : null,
        usuario: UsuarioModel.fromJson(json['doador']),
        dataDoacao: DateTime.parse(json['datadoacao']),
      );
}
