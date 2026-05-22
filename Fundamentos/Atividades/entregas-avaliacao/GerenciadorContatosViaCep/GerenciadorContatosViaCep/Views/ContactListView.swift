import SwiftUI

struct ContactListView: View {
    @StateObject private var viewModel = ContactListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.contacts, id: \.id) { contact in
                    NavigationLink(destination: ContactFormView(viewModel: ContactFormViewModel(contact: contact))) {
                        VStack(alignment: .leading) {
                            Text(contact.name ?? "")
                                .font(.headline)
                            Text(contact.phone ?? "")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteContact)
            }
            .navigationTitle("Contatos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ContactFormView(viewModel: ContactFormViewModel())) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.fetchContacts()
            }
        }
    }
}
