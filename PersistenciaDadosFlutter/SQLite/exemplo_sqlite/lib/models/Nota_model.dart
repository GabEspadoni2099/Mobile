//criar a classe model para Notas

class Nota {
  //atributos
  final int? id; //permite criar objeto com id nulo
  final String titulo;
  final String conteudo;

  //construtor
  Nota({
    this.id,
    required this.titulo,
    required this.conteudo,
  }); //construtor com os atributos

  //métodos
  //converter dados para o banco de dados
  //método MAP => converte um objeto da classe Nota um Map(para inserir no Banco de Dados)
  Map<String, dynamic> toMap() {
    return {
      "id" : id,
      "titulo": titulo,
      "conteudo": conteudo
    };
  }
}
