//
//  PersistenceController.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import Foundation
internal import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DespesasModel")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Erro ao carregar Core Data: \(error), \(error.userInfo)")
            }
        }
    }
}
