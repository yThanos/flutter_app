import 'package:app_flutter/model/produto.dart';

class Lote{
  int? codigo;
  Produto produto;
  int? lote;
  int? qntd;
  String? validade;

  Lote({required this.produto, this.lote, this.validade, this.qntd, this.codigo});

  Map<String, dynamic> toMap() {
    return{
      'codigo': codigo,
      'produto': produto.toMap(),
      'lote': lote,
      'quantidade': qntd,
      'validade': validade
    };
  }

  factory Lote.fromMap(Map<String, dynamic> json){
    return Lote(
      produto: Produto.fromMap(json['produto']),
      codigo: json['codigo'],
      qntd: json['quantidade'],
      validade: json['validade'],
      lote: json['lote']
    );
  }
}