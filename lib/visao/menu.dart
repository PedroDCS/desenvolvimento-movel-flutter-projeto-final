import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluxo/visao/cadGasto.dart';
import 'package:fluxo/visao/cadReceita.dart';
import 'package:fluxo/visao/cadTipoGasto.dart';
import 'package:fluxo/visao/cadTipoReceita.dart';
import 'package:fluxo/visao/principal.dart';
import 'package:fluxo/visao/relatorios.dart';

//indice de seleção da tela
int _selectedIndex = 0;

//vetor de telas a serem utilizadas
List<Widget> _stOptions = <Widget>[
  Principal(),
  CadGasto(),
  CadReceita(),
  //CadTipoGasto(),
  //CadTipoReceita(),
  //Relatorios(),
];

class Navegar extends StatefulWidget {
  int _opcao;

  //contrutor passando o indice da tela selecionada
  Navegar(this._opcao);

  @override
  _NavegarState createState() => _NavegarState(this._opcao);
}

class _NavegarState extends State<Navegar> {
  //construtor
  _NavegarState(this._opcao);
  int _opcao;

  @override
  void initState() {
    _selectedIndex = _opcao;
  }

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
          //corpo da aplicação, aqui são setadas as telas
          body: _stOptions.elementAt(_selectedIndex),

          //aqui é construido o NavigationDrawer
          drawer: Drawer(
            backgroundColor: Colors.purple[50],
            child: ListView(
              children: <Widget>[
                //cabeçalho do NavDrawer
                UserAccountsDrawerHeader(
                  accountName: Text("Fluxo App"),
                  accountEmail: Text("Aplicativo de apoio financeiro"),
                  decoration: BoxDecoration(
                    color: Color(0xFFffffff),
                    gradient: LinearGradient(
                        colors: [Colors.purple[600], Colors.orange[400]]),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 10.0,
                    backgroundImage: NetworkImage(
                        'https://www.ifmg.edu.br/portal/imagens/logovertical.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  arrowColor: Colors.teal,
                ),

                //lista de opções do NavDrawer
                ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Principal"),
                    subtitle: Text("Tela inicial do App"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Navegar(0)));
                    }),
                ListTile(
                    leading: Icon(Icons.remove_circle),
                    title: Text("Gastos"),
                    subtitle: Text("Cadastro de gastos"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Navegar(1)));
                      //Navigator.pop(context);
                    }),
                ListTile(
                    leading: Icon(Icons.add_circle),
                    title: Text("Receitas"),
                    subtitle: Text("Cadastros de receitas"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Navegar(2)));
                      //Navigator.pop(context);
                    }),
                ListTile(
                    leading: Icon(Icons.money_off),
                    title: Text("Tipo de gastos"),
                    subtitle: Text("Cadastros de tipos de gastos"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadTipoGasto()));
                      //Navigator.pop(context);
                    }),
                ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text("Tipo de Receitas"),
                    subtitle: Text("Cadastros de tipos de receitas"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadTipoReceita()));
                      //Navigator.pop(context);
                    }),
                ListTile(
                    leading: Icon(Icons.list),
                    title: Text("Relatórios"),
                    subtitle: Text("Relatórios de gastos"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Relatorios()));
                      //Navigator.pop(context);
                    })
              ],
            ),
          ),

          //botões do BN
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.orangeAccent,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Principal'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.remove_circle),
                title: Text('Gastos'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                title: Text('Receitas'),
              ),
              /*
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            title: Text('T. Gasto'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('T. Receita'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Relatorios'),
          ),
          */
            ],

            unselectedItemColor: Colors.white,

            currentIndex: _selectedIndex,

            selectedItemColor: Colors.purple[600],
            //greenAccent,
            onTap:
                _onItemTapped, //chama o métdodo onItemTapped ao clicar no botao do BTNNavigation
          ),
        ));
  }

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
