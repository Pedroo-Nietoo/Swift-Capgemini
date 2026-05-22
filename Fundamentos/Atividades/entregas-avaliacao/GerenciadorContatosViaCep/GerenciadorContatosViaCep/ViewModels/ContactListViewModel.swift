import SwiftUI
internal import CoreData
import Combine

@MainActor
class ContactListViewModel: ObservableObject {
    @Published var contacts: [ContactEntity] = []
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    func fetchContacts() {
        let request = NSFetchRequest<ContactEntity>(entityName: "ContactEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ContactEntity.name, ascending: true)]
        
        do {
            contacts = try viewContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func deleteContact(at offsets: IndexSet) {
        for index in offsets {
            let contact = contacts[index]
            viewContext.delete(contact)
        }
        
        do {
            try viewContext.save()
            fetchContacts()
        } catch {
            print(error)
        }
    }
}
