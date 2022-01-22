import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

final styleLabel = TextStyle(color: Colors.black, fontSize: 16);

class Relatorios extends StatefulWidget {
  @override
  _RelatoriosState createState() => _RelatoriosState();
}

class _RelatoriosState extends State<Relatorios> {
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple[600], Colors.orange])),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Fluxo"),
              backgroundColor: Colors.purple[600],
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple[600], Colors.orange])),
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Relatórios"),
                  backgroundColor: Colors.transparent,
                ),
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Clique no botão para consumir o webservice",
                            style: styleLabel,
                          )),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ButtonTheme(
                          height: 60,
                          child: RaisedButton(
                            onPressed: _eventoBotao,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15)),
                            child: Text(
                              "Consumir",
                              style:
                                  TextStyle(color: Colors.yellow, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  _eventoBotao() async {
    String dados = await getJSONData();
    setState(() {
      Toast.show(dados, context);
    });
  }

  Future<String> getJSONData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL"),
        headers: {"Accept": "application/json"});
    String data = response.body;
    return data;
  }
}
