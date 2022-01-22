import 'package:fluxo/modelo/bd/bd_core.dart';
import 'package:fluxo/modelo/beans/receita.dart';

class CReceitas{

  Future<int> insert(Receita g) async {
    int id = await BdCore.instance.insert(g.toMap(),BdCore.tableReceita);
    print('linha inserida id: $id');
    return id;
  }
  Future<int> update(Receita g) async {
    final linhasAfetadas = await BdCore.instance.update(g.toMap(),BdCore.tableReceita);
    print('atualizadas $linhasAfetadas linha(s)');
    return linhasAfetadas;
  }
  Future<int> deletar(int id) async {
    //final id = await BdCore.instance.queryRowCount(BdCore.tableReceita);
    final linhaDeletada = await BdCore.instance.delete(id, BdCore.tableReceita);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
    return linhaDeletada;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final todasLinhas = await BdCore.instance.queryAllRows(BdCore.tableReceita);
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
    return todasLinhas;
  }

  Future<List<Receita>> getAllList() async {
    final todasLinhas = await BdCore.instance.queryAllRows(BdCore.tableReceita);
    List<Receita> lg = List.generate(todasLinhas.length, (i) {
      return Receita(
          todasLinhas[i]['id'],
          todasLinhas[i]['tipo_receita_id'],
          todasLinhas[i]['observacoes'],
          todasLinhas[i]['dataHora'],
          todasLinhas[i]['valor']
      );
    });
    return lg;
  }

  Future<Receita> get(int id) async {
    String sql = ""
        "SELECT * "
        "FROM receita "
        "WHERE id = $id;";
    final todasLinhas = await BdCore.instance.querySQL(sql);
    List<Receita> lg = List.generate(todasLinhas.length, (i) {
      return Receita(
          todasLinhas[i]['id'],
          todasLinhas[i]['tipo_receita_id'],
          todasLinhas[i]['observacoes'],
          todasLinhas[i]['dataHora'],
          todasLinhas[i]['valor']
      );
    });
    Receita c = null;
    try {
      c = lg.elementAt(0);
    }catch(_){}
    return c;
  }
/*
  ///Select na tabela de pessoas fazendo join com a tabela de clientes,
  ///retornando a lista de todos os clientes tambem com as informações da tabela pessoa.
  Future<List<PessoaAmbulante>> getAllListAmbulante() async {
    String sql =
        "SELECT "
        " ambulante.id as id, "
        " pessoa.nome as nome, "
        " pessoa.sobrenome as sobrenome, "
        " pessoa.cpf as cpf, "
        " pessoa.observacao as observacao, "
        " ambulante.latitude as latitude, "
        " ambulante.longitude as longitude "

        "FROM "
        " pessoa INNER JOIN ambulante ON(pessoa.id = ambulante.pessoa_id);";

    final todasLinhas = await BdCore.instance.querySQL(sql);
    List<PessoaAmbulante> lc = List.generate(todasLinhas.length, (i) {
      return PessoaAmbulante(
          todasLinhas[i]['id'],
          todasLinhas[i]['nome'],
          todasLinhas[i]['sobrenome'],
          todasLinhas[i]['cpf'],
          todasLinhas[i]['obsevacao'],
          todasLinhas[i]['latitude'],
          todasLinhas[i]['longitude']
      );
    });
    return lc;
  }
*/
}
