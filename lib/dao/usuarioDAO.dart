import 'package:sqflite/sqflite.dart';

import '../model/usuario.dart';
import 'OpenDatabase.dart';

class UsuarioDAO{
  adicionar(Usuario u) async{
    final Database db = await getDatabase();
    db.insert('USUARIOS',u.toMap());
  }

  Future<List<Usuario>> getUsuarios() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('USUARIOS');

    return List.generate(maps.length, (i) {
      return Usuario(
          email: maps[i]['email'],
          senha: maps[i]['senha'],
          codigo: maps[i]['codigo'],
          nome: maps[i]['nome'],
          telefone: maps[i]['telefone']
      );
    });
  }

  Future<Usuario> getUser(String email) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> map = await db.query('USUARIOS', where: "email = ?", whereArgs: [email]);
    if(map.isEmpty){
      print("CAIU");
      return new Usuario(email: "emailNãosExistePuts", senha: "1234");
    }
    return Usuario(
      email: map[0]['email'],
      senha: map[0]['senha'],
      nome: map[0]['nome'],
      telefone: map[0]['telefone'],
      codigo: map[0]['codigo']
    );
  }

  Future<Usuario> getUserById(int id) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> map = await db.query('USUARIOS', where: "codigo = ?", whereArgs: [id]);

    return Usuario(
        email: map[0]['email'],
        senha: map[0]['senha'],
        nome: map[0]['nome'],
        telefone: map[0]['telefone'],
        codigo: map[0]['codigo']
    );
  }
}