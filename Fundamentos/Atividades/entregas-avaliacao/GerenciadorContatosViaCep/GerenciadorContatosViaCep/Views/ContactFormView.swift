import SwiftUI

struct ContactFormView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ContactFormViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Dados Pessoais")) {
                TextField("Nome", text: $viewModel.name)
                TextField("E-mail", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                TextField("Telefone", text: $viewModel.phone)
                    .keyboardType(.phonePad)
                DatePicker("Nascimento", selection: $viewModel.birthDate, displayedComponents: .date)
            }
            
            Section(header: Text("Endereço")) {
                TextField("CEP", text: $viewModel.zipCode)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.zipCode) { newValue in
                        if newValue.count == 8 {
                            viewModel.fetchAddress()
                        }
                    }
                TextField("Logradouro", text: $viewModel.street)
                TextField("Número", text: $viewModel.number)
                TextField("Bairro", text: $viewModel.neighborhood)
                TextField("Cidade", text: $viewModel.city)
                TextField("Estado", text: $viewModel.state)
            }
        }
        .navigationTitle(viewModel.contactToEdit == nil ? "Novo Contato" : "Editar Contato")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Salvar") {
                    viewModel.save()
                    dismiss()
                }
            }
        }
    }
}
