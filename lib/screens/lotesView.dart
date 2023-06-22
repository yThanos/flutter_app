import 'package:app_flutter/dao/loteDAO.dart';
import 'package:app_flutter/model/lote.dart';
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
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.73,
            child: FutureBuilder<List<Lote>>(
              future: LoteDAO().getLotes(),
              initialData: [],
              builder: (context, snapshot){
                if(snapshot.hasData) {
                  final List<Lote>? lotes = snapshot.data;
                  return ListView.builder(
                    itemCount: lotes?.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${lotes![index].produto}"),
                            Text("Lote: ${lotes[index].lote}")
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Quantidade: ${lotes[index].qntd}"),
                            Text("Vencimento: ${lotes[index].validade}")
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
