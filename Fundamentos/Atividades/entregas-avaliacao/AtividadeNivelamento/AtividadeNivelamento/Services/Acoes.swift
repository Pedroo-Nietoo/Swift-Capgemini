import Foundation

struct Acoes<T: Entidade> {

    private var lista: [T] = []

    mutating func cadastrar(_ valor: T) throws {
        if lista.contains(where: { $0.nome.lowercased() == valor.nome.lowercased() }) {
            throw ErroContato.nomeDuplicado
        }

        if let contato = valor as? Contato {
            let telefoneNovo = normalizarTelefone(contato.telefone)

            if lista.contains(where: {
                if let existente = $0 as? Contato {
                    return normalizarTelefone(existente.telefone) == telefoneNovo
                }
                return false
            }) {
                throw ErroContato.telefoneDuplicado
            }
        }

        lista.append(valor)
    }

    mutating func alterar(id: UUID, novoValor: T) throws {
        guard let index = lista.firstIndex(where: { $0.id == id }) else {
            throw ErroContato.idInvalido
        }

        if lista.contains(where: {
            $0.nome.lowercased() == novoValor.nome.lowercased() && $0.id != id
        }) {
            throw ErroContato.nomeDuplicado
        }

        if let novo = novoValor as? Contato {
            let telefoneNovo = normalizarTelefone(novo.telefone)

            if lista.contains(where: {
                if let existente = $0 as? Contato {
                    return normalizarTelefone(existente.telefone) == telefoneNovo
                        && existente.id != id
                }
                return false
            }) {
                throw ErroContato.telefoneDuplicado
            }
        }

        lista[index] = novoValor
    }

    func listar() -> [T] {
        lista
    }

    mutating func remover(id: UUID) throws {
        guard let index = lista.firstIndex(where: { $0.id == id }) else {
            throw ErroContato.idInvalido
        }
        lista.remove(at: index)
    }
    
    
    func normalizarTelefone(_ telefone: String) -> String {
        telefone.filter { $0.isNumber }
    }
}
