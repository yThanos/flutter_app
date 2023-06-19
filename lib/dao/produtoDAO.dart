import 'package:sqflite/sqflite.dart';

import '../model/produto.dart';
import 'OpenDatabase.dart';

class ProdutoDAO{

  adicionar(Produto p) async{
    final Database db = await getDatabase();
    db.insert('PRODUTOS',p.toMap());
  }

  Future<List<Produto>> getProdutos() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('PRODUTOS');

    return List.generate(maps.length, (i) {
      return Produto(
          codigo: maps[i]['codigo'],
          nome: maps[i]['nome'],
          valor: maps[i]['valor']
      );
    });
  }

  Future<Produto> getProdutoById(int? id) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> map = await db.query('PRODUTOS', where: "codigo = ?", whereArgs: [id]);

    return Produto(
        nome: map[0]['nome'],
        valor: map[0]['valor'],
        codigo: map[0]['codigo']
    );
  }
}