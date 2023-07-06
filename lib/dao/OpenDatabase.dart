import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{

  final String path = join(await getDatabasesPath(), 'db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute('CREATE TABLE TOKEN (token TEXT, codigo INTEGER)');
        db.execute('INSERT INTO TOKEN ("", 1)');
      },
      version: 4);

}