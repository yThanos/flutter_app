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

  Lote.fromMap(Map<String, dynamic> json):
    codigo = json['codigo'],
    produto = Produto.fromMap(json['produto']),
    lote = json['lote'],
    validade = json['validade'],
    qntd = json['quantidade'];

}