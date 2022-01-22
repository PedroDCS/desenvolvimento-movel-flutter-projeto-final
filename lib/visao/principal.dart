import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

final styleTexto = TextStyle(
  color: Colors.white,
  fontSize: 22,
);

class _PrincipalState extends State<Principal> {
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple[600], Colors.orange])),
        child: Scaffold(
          appBar: AppBar(
              title: Text("Principal"), backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Center(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 250,
                          height: 200,
                          child: Image.asset(
                            "imgs/logo.png",
                            width: 150,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Bem Vindo ao Fluxo de Caixa",
                            style: styleTexto,
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Pagina em Construção",
                            style: styleTexto,
                          ),
                        ],
                      ),
                    ],
                  )))),
        ));
  }
}
