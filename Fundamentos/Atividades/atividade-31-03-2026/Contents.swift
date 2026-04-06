class Aluno {
    var nome: String
    var nota1: Double
    var nota2: Double
    
    init(nome: String, nota1: Double, nota2: Double) {
        self.nome = nome
        self.nota1 = nota1
        self.nota2 = nota2
    }
    
    func calculaMedia(num1: Double, num2: Double) -> Double {
        return (num1 + num2) / 2
    }
    
    func verificarAprovado(media: Double) -> Bool {
        return media >= 7.0
    }
    
    func retornaDadosAluno() {
        let media = calculaMedia(num1: nota1, num2: nota2)
        let status = verificarAprovado(media: media) ? "Aprovado(a)" : "Reprovado(a)"
        
        print("Aluno(a) \(nome) obteve média \(media) e está \(status).")
    }
}

let aluno = Aluno(nome: "Pedro", nota1: 8.8, nota2: 10)
//aluno.retornaDadosAluno()





class Produto {
    var nome: String
    var valor: Double
    
    init(nome: String, valor: Double) {
        self.nome = nome
        self.valor = valor
    }
    
    func calcularDescontoComBaseEmPreco() -> Double {
        var desconto: Double = 0.0
        
        if (valor >= 1000) {
            desconto = valor * 0.10
        }
        
        return desconto
    }
    
    func calcularValorFinalComDesconto() {
        let desconto = calcularDescontoComBaseEmPreco()
        if (desconto > 0) {
            valor = valor - desconto
            print("Desconto aplicado de R$ \(desconto)")
        }
    }
    
    func retornaCheckout() {
        calcularValorFinalComDesconto()
        print("Produto: \(nome) - R$ \(valor)")
    }
}

let produto = Produto(nome: "Celular", valor: 149.90)
//produto.retornaCheckout()





struct FaixaImposto {
    let limite: Double
    let percentual: Double
}

class Descontos {
    var salarioBruto: Double
    var faltas: Int
    var salarioLiquido: Double = 0.0
    
    private let faixasImposto: [FaixaImposto] = [
        FaixaImposto(limite: 1560, percentual: 0.0),
        FaixaImposto(limite: 3120, percentual: 0.04),
        FaixaImposto(limite: 6240, percentual: 0.07),
        FaixaImposto(limite: 12480, percentual: 0.12),
        FaixaImposto(limite: .infinity, percentual: 0.15)
    ]

    init(salarioBruto: Double, faltas: Int) {
        self.salarioBruto = salarioBruto
        self.faltas = faltas
    }
    
    func calcularDescontoValeTransporte() -> Double {
        return salarioBruto * 0.06
    }

    func calcularDescontoImpostoDeRenda() -> Double {
        salarioBruto * (
            faixasImposto
                .first { salarioBruto <= $0.limite }?
                .percentual ?? 0
        )
    }
    
    func calcularBonificacao() -> Double {
        return faltas == 0 ? 400 : 0
    }
    
    func calcularSalarioLiquido() {
        let descontoValeTransporte = calcularDescontoValeTransporte()
        let descontoImpostoDeRenda = calcularDescontoImpostoDeRenda()
        let bonificacao = calcularBonificacao()
        salarioLiquido = salarioBruto - descontoValeTransporte - descontoImpostoDeRenda + bonificacao
        
        print("Desconto do vale transporte: \(descontoValeTransporte)")
        print("Desconto do imposto de renda: \(descontoImpostoDeRenda)")
        print("Bonificação: \(bonificacao)")
        print("Salário líquido: \(salarioLiquido)")
    }
}

let descontos = Descontos(salarioBruto: 3120, faltas: 0)
//descontos.calcularSalarioLiquido()





class Media {
    
    func calcularMedia(num1: Double, num2: Double) -> Double {
        return (num1 + num2) / 2
    }
    
    func calcularMedia(num1: Double, num2: Double, num3: Double) -> Double {
        return (num1 + num2 + num3) / 3
    }
    
    func calcularMedia(num1: Double, num2: Double, num3: Double, num4: Double) -> Double {
        return (num1 + num2 + num3 + num4) / 4
    }
}





class Cliente {
    private var nome: String?
    private var idade: Int?
    private var cidade: String?
    
    init() {
        print("Bom dia!")
    }
    
    init(nome: String) {
        self.nome = nome
        
        print("Bom dia \(nome)!")
    }
    
    init(nome: String, idade: Int) {
        self.nome = nome
        self.idade = idade
        print("Bom dia \(nome), você tem \(idade) anos!")
    }
    
    init(nome: String, idade: Int, cidade: String) {
        self.nome = nome
        self.idade = idade
        self.cidade = cidade
        print("Bom dia \(nome), você tem \(idade) anos e mora em \(cidade)!")
    }
}

//let cliente = Cliente()
//let cliente2 = Cliente(nome: "Pedro")
//let cliente3 = Cliente(nome: "Pedro", idade: 20)
//let cliente4 = Cliente(nome: "Pedro", idade: 20, cidade: "São José")





enum TipoAnimal {
    case PEIXE,
    LEAO,
    TOURO,
    URSO,
    AGUIA
}

struct Animal {
    var tipoAnimal: TipoAnimal
    var peso: Double
}

var leao = Animal(tipoAnimal: .LEAO, peso: 150.0)
var urso = leao
urso.tipoAnimal = .URSO
urso.peso = 400

//print(leao.tipoAnimal)
//print(leao.peso)
//print(urso.tipoAnimal)
//print(urso.peso)
