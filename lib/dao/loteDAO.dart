import 'package:sqflite/sqflite.dart';

import '../model/lote.dart';
import 'OpenDatabase.dart';

class LoteDAO{
  adicionar(Lote l) async{
    final Database db = await getDatabase();
    db.insert('LOTES',l.toMap());
  }

  Future<List<Lote>> getLotes() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('LOTES');

    return List.generate(maps.length, (i){
      return Lote(
        lote: maps[i]['lote'],
        produto: maps[i]['produto'],
        validade: maps[i]['validade'],
        qntd: maps[i]['qntd']
      );
    });
  }

  Future<Lote> getProdutoById(int id) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> map = await db.query('LOTES', where: "lote = ?", whereArgs: [id]);

    return Lote(
      lote: map[0]['lote'],
      validade: map[0]['validade'],
      produto: map[0]['produto'],
      qntd: map[0]['qntd']
    );
  }
}