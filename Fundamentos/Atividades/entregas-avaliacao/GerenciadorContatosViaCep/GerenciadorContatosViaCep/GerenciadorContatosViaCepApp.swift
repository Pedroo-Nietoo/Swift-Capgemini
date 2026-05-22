import SwiftUI
internal import CoreData

@main
struct GerenciadorContatosViaCepApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContactListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
