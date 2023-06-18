class Lote{
  int? produto;
  int? lote;
  int? qntd;
  String? validade;

  Lote({this.produto, this.lote, this.validade, this.qntd});

  Map<String, dynamic> toMap() {
    return{
      'produto': produto,
      'lote': lote,
      'qntd': qntd,
      'validade': validade
    };
  }

  Lote.fromJson(Map<String, dynamic> json):
    produto = json['produto'],
    lote = json['lote'],
    validade = json['validade'],
    qntd = json['qntd'];

}