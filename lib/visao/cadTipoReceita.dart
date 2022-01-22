import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluxo/controle/CTipoReceita.dart';
import 'package:fluxo/modelo/beans/tipoReceita.dart';

class CadTipoReceita extends StatefulWidget {
  @override
  _CadTipoReceitaState createState() => _CadTipoReceitaState();
}

class _CadTipoReceitaState extends State<CadTipoReceita> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fluxo"),
          backgroundColor: Colors.purple[600],
        ),
        //backgroundColor: Colors.black12,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple[600], Colors.orange])),
          child: Scaffold(
            appBar: AppBar(
              title: Text("Tipo de Receita"),
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                color: Colors.pink[50],
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 9),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Nome:",
                                          style: TextStyle(fontSize: 15)),
                                      TextField(
                                        controller: _tecNome,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.pink[50],
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 9),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Descrição:",
                                          style: TextStyle(fontSize: 15)),
                                      TextField(
                                        maxLines: 2,
                                        controller: _tecDescricao,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 190,
                          child: ButtonTheme(
                            height: 60.0,
                            child: RaisedButton(
                              onPressed: () {
                                _insereTipoReceita();
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              color: Colors.blue[400],
                            ),
                          ),
                        )
                      ],
                    )),
                Divider(
                  height: 10,
                ),
                Text("::Tipos de receita Cadastrados::",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(children: _listViewTipoReceita),
                ))
              ],
            ),
          ),
        ));
  }

  //controllers dos texts fields
  TextEditingController _tecNome = TextEditingController();
  TextEditingController _tecDescricao = TextEditingController();

  //lista de tipo de gastos
  List<TipoReceita> _tiposReceita = List();

  //listView de tipos de gastos
  List<Widget> _listViewTipoReceita = List<Widget>();

  /**
   * Método responsável por construir o listview
   */
  _setListView() async {
    //busca lista de objetos Gasto do BD
    _tiposReceita = await CTipoReceitas().getAllList();

    //monta listView já na treade de visualização de forma dinâmica
    setState(() {
      try {
        _listViewTipoReceita = _tiposReceita
            .map(
              (_data) => Card(
                color: Colors.pink[50],
                elevation: 3,
                child: Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _data.nome.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              Text(
                                _data.descricao.toString(),
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 2),
                        height: 56,
                        width: 56,
                        child: ButtonTheme(
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              _deleteTipoGasto(_data.id);
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList();
      } catch (_) {
        print("Não foi possível!");
        /*Toast.show("Não foi possível !", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);*/
      }
    });
  }

  _insereTipoReceita() {
    TipoReceita g = TipoReceita(null, _tecNome.text, _tecDescricao.text);
    CTipoReceitas().insert(g);
    _tecNome = TextEditingController();
    _tecDescricao = TextEditingController();
    setState(() {
      _setListView();
    });
  }

  _deleteTipoGasto(int id) {
    CTipoReceitas().deletar(id);
    setState(() {
      _setListView();
    });
  }

  /**
   * Método usado para inicialiar objetos e elementos ao criar a tela
   */
  @override
  void initState() {
    super.initState();

    //gera a listagem de elementos na thread de visão(de forma dinâmica)
    setState(() {
      _setListView();
    });
  }
}
