import SwiftUI
internal import CoreData
import Combine

@MainActor
class ContactFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var birthDate: Date = Date()
    @Published var zipCode: String = ""
    @Published var neighborhood: String = ""
    @Published var street: String = ""
    @Published var number: String = ""
    @Published var state: String = ""
    @Published var city: String = ""
    
    private let viewContext = PersistenceController.shared.container.viewContext
    private let viaCEPService = ViaCEPService()
    var contactToEdit: ContactEntity?
    
    init(contact: ContactEntity? = nil) {
        if let contact = contact {
            self.contactToEdit = contact
            self.name = contact.name ?? ""
            self.email = contact.email ?? ""
            self.phone = contact.phone ?? ""
            self.birthDate = contact.birthDate ?? Date()
            self.zipCode = contact.zipCode ?? ""
            self.neighborhood = contact.neighborhood ?? ""
            self.street = contact.street ?? ""
            self.number = contact.number ?? ""
            self.state = contact.state ?? ""
            self.city = contact.city ?? ""
        }
    }
    
    func fetchAddress() {
        guard zipCode.count >= 8 else { return }
        
        Task {
            do {
                let response = try await viaCEPService.fetchAddress(cep: zipCode)
                if response.erro == nil {
                    self.street = response.logradouro ?? ""
                    self.neighborhood = response.bairro ?? ""
                    self.city = response.localidade ?? ""
                    self.state = response.uf ?? ""
                }
            } catch {
                print(error)
            }
        }
    }
    
    func save() {
        let contact = contactToEdit ?? ContactEntity(context: viewContext)
        
        if contactToEdit == nil {
            contact.id = UUID()
        }
        
        contact.name = name
        contact.email = email
        contact.phone = phone
        contact.birthDate = birthDate
        contact.zipCode = zipCode
        contact.neighborhood = neighborhood
        contact.street = street
        contact.number = number
        contact.state = state
        contact.city = city
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}
