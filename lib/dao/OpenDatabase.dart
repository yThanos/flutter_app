import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{

  final String path = join(await getDatabasesPath(), 'db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute('CREATE TABLE login (token TEXT, codigo INTEGER)');
        db.insert('login', {"token": "token", "codigo": 1});
      },
      version: 1);

}

saveToken(String token) async{
  final Database db = await getDatabase();
  db.update("login", {"token":token}, where: "codigo = ?", whereArgs: [1]);
}

Future<String> getToken() async{
  final Database db = await getDatabase();
  List<Map<String, dynamic>> maps = await db.query("login", where: "codigo = ?", whereArgs: [1]);
  return maps[0]['token'];
}