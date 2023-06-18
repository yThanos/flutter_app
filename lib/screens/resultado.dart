import 'dart:convert';

import 'package:app_flutter/dao/loteDAO.dart';
import 'package:app_flutter/model/lote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class resultadocode extends StatefulWidget {
  const resultadocode({Key? key, required this.codigo}) : super(key: key);
  final String codigo;
  @override
  State<resultadocode> createState() => _resultadocodeState();
}

class _resultadocodeState extends State<resultadocode> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> lot = jsonDecode(widget.codigo);
    Lote lote = Lote.fromJson(lot);
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text(lote.toString()),
          ),
          ElevatedButton(
            onPressed: (){
              new LoteDAO().adicionar(lote);
            },
            child: Text("Adicionar lote")
          )
        ],
      ),
    );
  }
}
