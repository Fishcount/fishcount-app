import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  final int _versaoDB = 1;
  final String _nameDB = 'fishcount.db';

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, _nameDB);
    return await openDatabase(
      path,
      version: _versaoDB,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int versao) async {
    List<String> querys = [
      """
      create table usuario( 
          id integer not null primary key, 
          nome text,
          email text, 
          senha text
      );
      """,
      """
      create table telefone(
          id integer not null primary key,
          descricao text,
          tipoTelefone text,
          id_usuario integer
      );
      """,
      """
       create table email(
          id integer not null primary key,
          descricao text,
          tipoEmail text,
          id_usuario integer
       );
      """,
      """
      create table lote(
          id integer not null primary key,
          descricao text not null,
          id_usuario integer
      );   
      """,
      """
       create table tanque(
          id integer not null primary key,
          descricao text not null,
          especie text not null,
          ultimaAnalise text,
          proximaAnalise text,
          dataUltimaAnalise text,
          dataUltimoTratamento text,
          id_lote integer
       );
      """,
      """
       create table analise(
          id integer not null primary key,
          qtdeRacao float,
          pesoMedio float,
          qtdeMediaRacao float,
          dataAnalise text,
          id_tanque integer
       );
      """,
      """
       create table especie(
          id integer not null primary key,
          descricao text,
          pesoMedio float,
          tamanhoMedio float,
          qtdeMediaRacao integer,
          diasIntervalo integer,
          id_tanque integer
       );
      """,
      """
       create table taxaCrescimento(
          id integer not null primary key,
          periodoAnalise integer,
          qtdeAumento float,
          intervalo int,
          unidadeAumento text,
          unidadeIntervalo text,
          id_especie integer
       );
      """
    ];

    for (String query in querys) {
      await db.execute(query);
    }
  }
}
