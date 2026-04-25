import Foundation

var contatos = Acoes<Contato>()
var continuar = true

func inputObrigatorio(_ campo: String) throws -> String {
    while true {
        print("\(campo) (ou Q para cancelar): ", terminator: "")
        let entrada = readLine() ?? ""
        let valor = entrada.trimmingCharacters(in: .whitespacesAndNewlines)

        if valor.uppercased() == "Q" {
            throw ErroContato.canceladoPeloUsuario
        }

        if valor.isEmpty {
            print("❌ Campo inválido.")
            continue
        }

        return valor
    }
}

func inputIdade() throws -> Int {
    while true {
        let valor = try inputObrigatorio("Idade")
        if let idade = Int(valor), idade > 0 {
            return idade
        }
        print("❌ Idade inválida.")
    }
}

while continuar {

    print("""
    \n--- MENU ---
    1 - Cadastrar contato
    2 - Listar contatos
    3 - Alterar contato
    4 - Remover contato
    5 - Finalizar
    """)

    print("Escolha uma opção: ", terminator: "")
    let opcao = readLine() ?? ""

    switch opcao {

    case "1":
        do {
            let nome = try inputObrigatorio("Nome")
            let idade = try inputIdade()
            let telefone = try inputObrigatorio("Telefone")
            let email = try inputObrigatorio("Email")

            let contato = Contato(
                id: UUID(),
                nome: nome,
                idade: idade,
                telefone: telefone,
                email: email
            )

            try contatos.cadastrar(contato)
            print("✅ Contato cadastrado com sucesso!")
        } catch ErroContato.nomeDuplicado {
            print("❌ Nome já cadastrado.")
        } catch ErroContato.telefoneDuplicado {
            print("❌ Telefone já cadastrado.")
        } catch ErroContato.canceladoPeloUsuario {
            print("↩️ Cadastro cancelado.")
        }

    case "2":
        let lista = contatos.listar()

        if lista.isEmpty {
            print("Nenhum contato cadastrado.")
        } else {
            for c in lista {
                print("""
                ------------------
                ID: \(c.id.uuidString)
                Nome: \(c.nome)
                Idade: \(c.idade)
                Telefone: \(c.telefone)
                Email: \(c.email)
                """)
            }
        }

    case "3":
        let lista = contatos.listar()
        lista.forEach {
            print("ID: \($0.id.uuidString) | Nome: \($0.nome)")
        }

        do {
            let idString = try inputObrigatorio("ID do contato")
            guard let id = UUID(uuidString: idString) else { throw ErroContato.idInvalido }

            let nome = try inputObrigatorio("Novo nome")
            let idade = try inputIdade()
            let telefone = try inputObrigatorio("Novo telefone")
            let email = try inputObrigatorio("Novo email")

            let novoContato = Contato(
                id: id,
                nome: nome,
                idade: idade,
                telefone: telefone,
                email: email
            )

            try contatos.alterar(id: id, novoValor: novoContato)
            print("✅ Contato alterado com sucesso!")
        } catch ErroContato.nomeDuplicado {
            print("❌ Nome de usuário já cadastrado.")
        } catch ErroContato.telefoneDuplicado {
            print("❌ Telefone já cadastrado.")
        } catch ErroContato.idInvalido {
            print("❌ ID inválido.")
        } catch ErroContato.canceladoPeloUsuario {
            print("↩️ Alteração cancelada.")
        }

    case "4":
        let lista = contatos.listar()
        lista.forEach {
            print("ID: \($0.id.uuidString) | Nome: \($0.nome)")
        }

        do {
            let idString = try inputObrigatorio("ID do contato")
            guard let id = UUID(uuidString: idString) else { throw ErroContato.idInvalido }

            try contatos.remover(id: id)
            print("✅ Contato removido com sucesso!")
        } catch ErroContato.idInvalido {
            print("❌ ID inválido.")
        } catch ErroContato.canceladoPeloUsuario {
            print("↩️ Remoção cancelada.")
        }

    case "5":
        continuar = false
        print("Sistema finalizado.")

    default:
        print("❌ Opção inválida.")
    }
}
