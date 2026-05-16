//
//  ExpenseFormView.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import SwiftUI

struct ExpenseFormView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ExpenseViewModel
    
    var expenseToEdit: Expense?
    
    @State private var title: String = ""
    @State private var amountString: String = ""
    @State private var selectedCategory: ExpenseCategory = .energia
    @State private var selectedMonth: ExpenseMonth = .janeiro
    
    var body: some View {
        Form {
            Section(header: Text("Detalhes da Despesa")) {
                TextField("Descrição (Ex: Conta de Luz)", text: $title)
                
                TextField("Valor (Ex: 150.50)", text: $amountString)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Classificação")) {
                Picker("Categoria", selection: $selectedCategory) {
                    ForEach(ExpenseCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                
                Picker("Mês", selection: $selectedMonth) {
                    ForEach(ExpenseMonth.allCases) { month in
                        Text(month.rawValue).tag(month)
                    }
                }
            }
        }
        .navigationTitle(expenseToEdit == nil ? "Nova Despesa" : "Editar Despesa")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    salvar()
                }
                .disabled(title.isEmpty || amountString.isEmpty)
            }
        }
        .toolbarBackground(Color.appColorRed, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            if let expense = expenseToEdit {
                title = expense.title ?? ""
                amountString = String(format: "%.2f", expense.amount)
                
                if let catString = expense.category, let catEnum = ExpenseCategory(rawValue: catString) {
                    selectedCategory = catEnum
                }
                
                if let monthString = expense.month, let monthEnum = ExpenseMonth(rawValue: monthString) {
                    selectedMonth = monthEnum
                }
            } else {
                selectedMonth = viewModel.selectedMonth
            }
        }
    }
    
    private func salvar() {
        let amount = Double(amountString.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        
        viewModel.saveExpense(
            expense: expenseToEdit,
            title: title,
            amount: amount,
            category: selectedCategory,
            month: selectedMonth
        )
        dismiss()
    }
}
