class Produto{
  int? codigo;
  String nome;
  double valor;
  Produto({required this.valor, required this.nome, this.codigo});

  Map<String, dynamic> toMap(){
    return {
      'nome': nome,
      'valor': valor
    };
  }
  Produto.fromMap(Map<String, dynamic> map):
        valor = map['valor'],
        nome = map['nome'],
        codigo = map['codigo'];

}