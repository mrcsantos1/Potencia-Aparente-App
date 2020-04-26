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
              onPressed: () {},
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
              ),
              TextField(
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: "Módulo da corrente (A): ",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelText: "Fator de Potência: ",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 30.0),
                child: Container(
                    height: 70.0,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Calcular!",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.black,
                    )),
              ),
              Text(
                "glória a Deus",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          ),
        ));
  }
}
