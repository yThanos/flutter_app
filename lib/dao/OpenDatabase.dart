import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{

  final String path = join(await getDatabasesPath(), 'db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute('CREATE TABLE USUARIOS (codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, senha TEXT, email TEXT UNIQUE)');
      },
      version: 1);

}