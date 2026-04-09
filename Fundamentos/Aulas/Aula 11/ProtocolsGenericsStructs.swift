/*2º EXEMPLO*/

// 1º Implementar o protocols (Interface)
protocol Entidade {
    var id: Int { get }
    var nome: String { get }
}

// 2º Struct de Pessoa e Produto
struct Pessoa: Entidade{
    var id: Int
    var nome: String
    var cidade: String
}

struct Produto: Entidade{
    var id: Int
    var nome: String
    var valor: Double
}

// 3º Struct de Ações (Cadastrar e Listar)
struct Acoes<T: Entidade>{
    
    // Vetor
    private var vetor: [T] = []
    
    // Função para cadastrar
    mutating func cadastrar(valor: T) {
        vetor.append(valor)
    }
    
    // Função para selecionar
    func listar() -> [T] {
        return vetor
    }
    
}

// 4º Testar
// Criar objetos da Struct Acoes
var pessoas = Acoes<Pessoa>()
var produtos = Acoes<Produto>()

// Criar objetos da Struct Pessoa
let pessoa1 = Pessoa(id: 1, nome: "Beatriz", cidade: "São Paulo")
let pessoa2 = Pessoa(id: 2, nome: "André",   cidade: "Salvador")

// Criar objetos da Struct Produto
let produto1 = Produto(id: 1, nome: "MacBook Air", valor: 11500.00)
let produto2 = Produto(id: 2, nome: "iPhone 17",   valor: 9800.80)

// Cadastrar e listar pessoas e produtos
pessoas.cadastrar(valor: pessoa1)
pessoas.cadastrar(valor: pessoa2)
print(pessoas.listar())

produtos.cadastrar(valor: produto1)
produtos.cadastrar(valor: produto2)
print(produtos.listar())














/*1º EXEMPLO*/

//// 1º Implementar o protocols (Interface)
//protocol Entidade {
//    var id: Int { get }
//    var nome: String { get }
//}
//
//// 2º Struct de Pessoa
//struct Pessoa: Entidade{
//    var id: Int
//    var nome: String
//    var cidade: String
//}
//
//// 3º Struct de Ações (Cadastrar e Listar)
//struct Acoes{
//
//    // Vetor para armazenar pessoas
//    private var vetor: [Pessoa] = []
//
//    // Função para cadastrar
//    mutating func cadastrar(p: Pessoa) {
//        vetor.append(p)
//    }
//
//    // Função para selecionar
//    func listar() {
//        for p in vetor {
//            print("ID: \(p.id)")
//            print("NOME: \(p.nome)")
//            print("CIDADE: \(p.cidade)")
//            print("-------------------")
//        }
//    }
//
//}
//
//// 4º Testar
//let pessoa1 = Pessoa(id: 1, nome: "Angela", cidade: "Londrina")
//let pessoa2 = Pessoa(id: 2, nome: "Bruno",  cidade: "Campinas")
//
//var acoes = Acoes()
//
//acoes.cadastrar(p: pessoa1)
//acoes.cadastrar(p: pessoa2)
//
//acoes.listar()













