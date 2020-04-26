import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController tensaoController = TextEditingController();
  TextEditingController correnteController = TextEditingController();
  TextEditingController fatorPotenciaController = TextEditingController();

  String _infoText1 = "Informe os dados";
  String _infoText2 = "";
  String _infoText3 = "";
  String _infoText4 = "";

  bool _indutivo = false;

  void _resetFields() {
    tensaoController.text = "";
    correnteController.text = "";
    fatorPotenciaController.text = "";
    _infoText1 = "Informe os dados";
    _infoText2 = "";
    _infoText3 = "";
    _infoText4 = "";
  }

  void _calculate() {
    setState(() {
      double tensao = double.parse(tensaoController.text);
      double corrente = double.parse(correnteController.text);
      double fp = double.parse(fatorPotenciaController.text);

      double ang = acos(fp);
      double smod = tensao * corrente;

      double p = smod * fp;

      double q = smod * sin(fp);

      if (_indutivo) {
        _infoText1 = "S polar = $smod, ${-ang * 180 / pi}°\tVA";
        _infoText2 = "P = $p\tW";
        _infoText3 = "Q = -$q\tVAr";
        _infoText4 = "S ret = $p - j$q";
      } else if (!_indutivo) {
        _infoText1 = "S polar = $smod, ${ang * 180 / pi}°\tVA";
        _infoText2 = "P = $p\tW";
        _infoText3 = "Q = $q\tVAr";
        _infoText4 = "S ret = $p + j$q";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calcula Potência Aparente"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white30,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.power,
                size: 200.0,
                color: Colors.black,
              ),
              TextField(
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: "Módulo da tensão (V): ",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                controller: tensaoController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: "Módulo da corrente (A): ",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                controller: correnteController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: "Fator de Potência",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                controller: fatorPotenciaController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Indutivo",
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0),
                  ),
                  Switch(
                    value: _indutivo,
                    onChanged: (value) {
                      setState(() {
                        _indutivo = value;
                      });
                    },
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.black,
                    activeTrackColor: Colors.white,
                    activeColor: Colors.black,
                  ),
                  Text(
                    "Capacitivo",
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 30.0),
                child: Container(
                    height: 70.0,
                    child: RaisedButton(
                      onPressed: _calculate,
                      child: Text(
                        "Calcular!",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.black,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    child: Text(
                      _infoText1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  Container(
                    height: 30.0,
                    child: Text(
                      _infoText2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  Container(
                    height: 30.0,
                    child: Text(
                      _infoText3,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  Container(
                    height: 30.0,
                    child: Text(
                      _infoText4,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
