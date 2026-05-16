//
//  GerenciadorDespesasDomesticasApp.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import SwiftUI
internal import CoreData

@main
struct GerenciadorDespesasDomesticasApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView(context: persistenceController.container.viewContext)
        }
    }
}
