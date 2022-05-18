class Querys {
  static const insertTaxaCrescimento = """
  insert into taxaCrescimento(
      qtdeAumento, 
      unidadeAumento, 
      intervalo, 
      unidadeIntervalo
      ) values (?, ?, ?, ?, ?)
      """;

  static const insertEspecie = """
  insert into especie( 
      descricao, 
      pesoMedio,
      unidadePeso,
      tamanhoMedio,
      unidadeTamanho,
      qtdeMediaRacao,
      unidadeRacao,
      diasIntervalo,
      id_taxa_crescimento
      ) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  """;

  static const queries = [
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
          ultimaAnalise text,
          proximaAnalise text,
          dataUltimaAnalise text,
          dataUltimoTratamento text,
          id_especie integer not null,
          id_lote integer not null
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
          unidadePeso text,
          tamanhoMedio float,
          unidadeTamanho text,
          qtdeMediaRacao integer,
          unidadeRacao text,
          diasIntervalo integer,
          id_taxa_crescimento integer
       );
      """,
    """
       create table taxaCrescimento(
          id integer not null primary key,
          qtdeAumento float,
          unidadeAumento text,
          intervalo int,
          unidadeIntervalo text
       );
      """
  ];
}
