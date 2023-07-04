import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/lote.dart';

class LoteDAO{
  final _url = Uri.parse("http://10.0.2.2:6969/flutter/lote");
  final _header = {'Content-Type': 'application/json'};

  adicionar(Lote l) async{
    print("teste3");
    print(l.toMap());
    await http.post(_url,headers: _header, body: jsonEncode(l.toMap()));
  }

  Future<List<Lote>> getLotes() async {
    var response = await http.get(_url, headers: _header);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    return jsonResponse.map<Lote>((json)=> Lote.fromMap(json)).toList();
  }

  Future<Lote> getProdutoById(int id) async {
    var response = await http.get(_url, headers: _header);

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    return Lote.fromMap(jsonResponse.map<Lote>((e)=> e['codigo'] = id));
  }
}