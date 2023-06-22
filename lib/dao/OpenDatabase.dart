import 'package:app_flutter/model/produto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{

  final String path = join(await getDatabasesPath(), 'db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute('CREATE TABLE USUARIOS (codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, senha TEXT, email TEXT UNIQUE)');
        db.execute('CREATE TABLE PRODUTOS (codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, valor REAL)');
        db.execute('CREATE TABLE LOTES (produto TEXT, lote INTEGER, qntd INTEGER, validade TEXT)');
        db.insert("PRODUTOS", Produto(valor: 10.00, nome: "Coca").toMap());
      },
      version: 2);

}