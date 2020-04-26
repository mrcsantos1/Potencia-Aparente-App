import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.Dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.black, // status bar color
    statusBarBrightness: Brightness.dark,
  ));
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController tensaoController = TextEditingController();
  TextEditingController correnteController = TextEditingController();
  TextEditingController fatorPotenciaController = TextEditingController();

  String _infoText1 = "Informe os dados";
  String _infoText2 = "";
  String _infoText3 = "";
  String _infoText4 = "";

  bool _indutivo = false;

  void _resetFields() {
    setState(() {
      tensaoController.text = "";
      correnteController.text = "";
      fatorPotenciaController.text = "";
      _infoText1 = "Informe os dados";
      _infoText2 = "";
      _infoText3 = "";
      _infoText4 = "";
      _formKey = GlobalKey<FormState>();
    });
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
      ang = -ang * 180 / pi;
      if (_indutivo) {
        _infoText1 =
            "S polar = ${smod.toStringAsPrecision(4)}, ${ang.toStringAsPrecision(4)}°\tVA";
        _infoText2 = "P = ${p.toStringAsPrecision(4)}\tW";
        _infoText3 = "Q = -${q.toStringAsPrecision(4)}\tVAr";
        _infoText4 =
            "S ret = ${p.toStringAsPrecision(4)} - j${q.toStringAsPrecision(4)}";
      } else if (!_indutivo) {
        _infoText1 = "S polar = $smod, ${ang.toStringAsPrecision(4)}°\tVA";
        _infoText2 = "P = ${p.toStringAsPrecision(4)}\tW";
        _infoText3 = "Q = ${q.toStringAsPrecision(4)}\tVAr";
        _infoText4 =
            "S ret = ${p.toStringAsPrecision(4)} + j${q.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calcula Potência Aparente \tBy MrcSantos"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white60,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.power,
                    size: 200.0,
                    color: Colors.black,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: "Módulo da tensão (V): ",
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 30.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    controller: tensaoController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira um valor para tensão!";
                      }
                      if (!isFloat(value)) {
                        return "Digite apenas números!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: "Módulo da corrente (A): ",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 30.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, style: BorderStyle.solid),
                        )),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    controller: correnteController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira um valor para tensão!";
                      }
                      if (!isFloat(value)) {
                        return "Digite apenas números!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: "Fator de Potência",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 30.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, style: BorderStyle.solid),
                        )),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    controller: fatorPotenciaController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira um valor para tensão!";
                      }
                      if (!isFloat(value)) {
                        return "Digite apenas números!";
                        // ignore: missing_return, missing_return, missing_return, missing_return
                      }
                    },
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
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
            )));
  }
}
