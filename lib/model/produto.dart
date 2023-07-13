class Produto{
  int? codigo;
  String? nome;
  double? valor;
  Produto({this.valor, this.nome, this.codigo});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'nome': nome,
      'valor': valor
    };
  }
  Produto.fromMap(Map<String, dynamic> map):
        valor = map['valor'],
        nome = map['nome'],
        codigo = map['codigo'];

}