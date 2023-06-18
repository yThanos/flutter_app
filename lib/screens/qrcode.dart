import 'dart:convert';
import 'dart:io';

import 'package:app_flutter/dao/loteDAO.dart';
import 'package:app_flutter/screens/menu.dart';
import 'package:app_flutter/screens/resultado.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../model/lote.dart';

class qrcode extends StatefulWidget {
  const qrcode({Key? key}) : super(key: key);

  @override
  State<qrcode> createState() => _qrcodeState();
}

class _qrcodeState extends State<qrcode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? ElevatedButton(
                    onPressed: (){
                      Map<String, dynamic> lot = jsonDecode(result!.code!);
                      Lote lote = Lote.fromJson(lot);
                      LoteDAO().adicionar(lote);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return menu();
                      }));
                    },
                    child: Text("Adicionar lote")
                  )
                  : Text("Mire para um QRcode"),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
