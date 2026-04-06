//Atividade 1

//Peça um nome, idade e cidade. Concatene em uma frase:
var nome: String = "Pedro"
var idade: Int = 20
var cidade: String = "São José"

print("O meu nome é \(nome), tenho \(idade) anos e moro em \(cidade)")

//Peça dois números inteiros. Se forem iguais, exiba a soma, caso contrário, exiba a multiplicação
var num1 = 5
var num2 = 8

if num1 == num2 {
    print("A soma é \(num1 + num2)")
} else {
    print("A multiplicação é \(num1 * num2)")
}

//Informe um ano, retorne se é bisexto ou não
var ano = 2026

if ano.isMultiple(of: 4) {
    print("O ano \(ano) é bisexto")
} else {
    print("O ano \(ano) não é bisexto")
}

// Deverá ser pedido três números inteiros distintos. Retorne qual deles é o menor

var n1: Int = 8
var n2: Int = 10
var n3: Int = 12

if n1 < n2 && n1 < n3 {
    print("O menor número é \(n1)")
} else if n2 < n1 && n2 < n3 {
    print("O menor número é \(n2)")
} else {
    print("O menor número é \(n3)")
}

//Peça um número inteiro. Retorne o sucessor e o antecessor

var numero: Int = 7

print("O sucessor de \(numero) é \(numero + 1) e o antecessor é \(numero - 1)")


//Laços de Repetição

// Peça um número inteiro. Retorne a tabuada daquele valor
var numTabuada: Int = 3

for i in 1...10 {
    print("\(numTabuada) x \(i) = \(numTabuada * i)")
}

//O usuário informa dois números. Percorre os números informados e exeiba:
//a. Quantidade de números informados
//b. Quantidade de pares
//c. Quantidade de ímpares
//d. Média geral dos valores informados

var numerososNumeros: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var quantidadeNumeros: Int = numerososNumeros.count
var quantidadePares: Int = 0
var quantidadeImpares: Int = 0
var somaNumeros: Int = 0

for numero in numerososNumeros {
    if numero.isMultiple(of: 2) {
        quantidadePares += 1
    } else {
        quantidadeImpares += 1
    }
    somaNumeros += numero
}

print("A quantidade de números informados é de \(quantidadeNumeros)")
print("A quantidade de números pares é de \(quantidadePares)")
print("A quantidade de números ímpares é de \(quantidadeImpares)")
print("A média geral é de \(somaNumeros / quantidadeNumeros)")

//Array List

// Peça cinco números distintos. Exiba-os em ordem crescente
var numerosDesordenados: [Int] = [1, 3, 2, 5, 4]
print(numerosDesordenados.sorted())

//Haverá um vetor contendo cinco nomes. Percorra o vetor, e exiba a quantidade de vogais e consoantes que cada nome possui.

var nomes: [String] = ["Ana", "Bia", "Carlos", "Daniel", "Eva"]
var vogais: Int = 0
var consoantes: Int = 0

for nome in nomes {
    for caractere in nome {
        if "aeiouAEIOU".contains(caractere) {
            vogais += 1
        } else {
            consoantes += 1
        }
    }
}

print("A quantidade de vogais é de \(vogais)")
print("A quantidade de consoantes é de \(consoantes)")

//Crie um vetor contendo dez números inteiros. Exiba o vetor em ordem contrária.
var numerosEmOrdemAleatoria: [Int] = [1, 4, 2, 5, 3, 6, 7, 8, 9, 10]
print(numerosEmOrdemAleatoria.sorted(by: >))
