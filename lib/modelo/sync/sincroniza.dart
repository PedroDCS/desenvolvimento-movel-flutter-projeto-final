import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluxo/modelo/beans/gasto.dart';
import 'package:fluxo/modelo/beans/receita.dart';
import 'package:fluxo/modelo/beans/tipoGasto.dart';
import 'package:fluxo/modelo/beans/tipoReceita.dart';


class Sincroniza {
  //TODO fazer o registro do usuário que enviou cada dado no nome das coleções no firebase, assim montamos um sistema de bkp multiusuário

  //TODO fazer o metodo de setar a data e hora da ultima atualização no servidor
  /*Future setUltimaAtualizacao() async{
    await Firestore.instance.document("ultimaAtualizacao").setData(
        {
          "date": DateTime.now(),
        });
  }*/
  //TODO fazer a consulta da data e hora da ultima atualização no servidor
  /*Future<UltimaAtualizacao> getUltimaAtualizacao() async{
    var s = await Firestore.instance.document("ultimaAtualizacao").get();
    UltimaAtualizacao resp = UltimaAtualizacao.fromMap(s.data);
    return resp;
  }*/

  Future addTipoGasto(List<TipoGasto> tgs) async{
    for(TipoGasto tg in tgs)
      await Firestore.instance.collection("TipoGasto").add( tg.toMap());
  }

  Future<List<TipoGasto>> getAllTipoGasto() async{
    var teste = await Firestore.instance.collection("TipoGasto").getDocuments();
    //print(teste.toString());
    List<TipoGasto> lista = new List();
    for (DocumentSnapshot ds in teste.documents){
      TipoGasto tg = TipoGasto.fromMap(ds.data);
      lista.add(tg);
    }
    return lista;
  }

  Future delAllTipoGasto() async{
    await Firestore.instance.collection("TipoGasto").document().delete();
  }

  Future addTipoReceita(List<TipoReceita> tgs) async{
    for(TipoReceita tg in tgs)
      await Firestore.instance.collection("TipoReceita").add( tg.toMap());
  }

  Future<List<TipoReceita>> getAllTipoReceita() async{
    var teste = await Firestore.instance.collection("TipoReceita").getDocuments();
    print(teste.toString());
    List<TipoReceita> lista = new List();
    for (DocumentSnapshot ds in teste.documents){
      TipoReceita tg = TipoReceita.fromMap(ds.data);
      lista.add(tg);
    }
    return lista;
  }

  Future delAllTipoReceita() async{
    await Firestore.instance.collection("TipoReceita").document().delete();
  }
  Future addReceita(List<Receita> tgs) async{
    for(Receita tg in tgs)
      await Firestore.instance.collection("Receita").add( tg.toMap());
  }

  Future<List<Receita>> getAllReceita() async{
    var teste = await Firestore.instance.collection("Receita").getDocuments();
    print(teste.toString());
    List<Receita> lista = new List();
    for (DocumentSnapshot ds in teste.documents){
      Receita tg = Receita.fromMap(ds.data);
      lista.add(tg);
    }
    return lista;
  }

  Future delAllReceita() async{
    await Firestore.instance.collection("Receita").document().delete();
  }
  Future addGasto(List<Gasto> tgs) async{
    for(Gasto tg in tgs)
      await Firestore.instance.collection("Gasto").add( tg.toMap());
  }

  Future<List<Gasto>> getAllGasto() async{
    var teste = await Firestore.instance.collection("Gasto").getDocuments();
    print(teste.toString());
    List<Gasto> lista = new List();
    for (DocumentSnapshot ds in teste.documents){
      Gasto tg = Gasto.fromMap(ds.data);
      lista.add(tg);
    }
    return lista;
  }

  Future delAllGasto() async{
    await Firestore.instance.collection("Gasto").document().delete();
  }
}