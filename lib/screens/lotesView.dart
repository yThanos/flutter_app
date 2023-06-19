import 'package:app_flutter/dao/loteDAO.dart';
import 'package:app_flutter/dao/produtoDAO.dart';
import 'package:app_flutter/model/lote.dart';
import 'package:app_flutter/model/produto.dart';
import 'package:flutter/material.dart';

class LoteView extends StatefulWidget {
  const LoteView({Key? key}) : super(key: key);

  @override
  State<LoteView> createState() => _LoteViewState();
}

class _LoteViewState extends State<LoteView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          FutureBuilder<List<Lote>>(
            future: LoteDAO().getLotes(),
            builder: (BuildContext context, snapshot){
              List<Lote>? lotes = snapshot.data;
              if(lotes != null){
                for(Lote lote in lotes){
                  FutureBuilder<Produto>(
                    future: ProdutoDAO().getProdutoById(lote.produto),
                    builder: (BuildContext context, snapshot){

                    },
                  );
                }
              }
            }
          )
        ],
      ),
    );
  }
}
