//
//  ExpenseViewModel.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import Foundation
internal import Combine
internal import CoreData

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var selectedMonth: ExpenseMonth = .janeiro
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchExpenses()
    }
    
    func fetchExpenses() {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Expense.title, ascending: true)]
        
        do {
            expenses = try context.fetch(request)
        } catch {
            print("Erro ao buscar despesas: \(error)")
        }
    }
        
    var filteredExpenses: [Expense] {
        expenses.filter { $0.month == selectedMonth.rawValue }
    }
    
    var totalForSelectedMonth: Double {
        filteredExpenses.reduce(0) { $0 + $1.amount }
    }
    
    var highestExpenseForSelectedMonth: Expense? {
        filteredExpenses.max(by: { $0.amount < $1.amount })
    }
    
    var expensesGroupedByCategory: [(category: String, total: Double)] {
        var grouped: [String: Double] = [:]
        for expense in filteredExpenses {
            let cat = expense.category ?? "Sem Categoria"
            grouped[cat, default: 0.0] += expense.amount
        }
        return grouped.map { (category: $0.key, total: $0.value) }
            .sorted { $0.total > $1.total }
    }
        
    func saveExpense(expense: Expense?, title: String, amount: Double, category: ExpenseCategory, month: ExpenseMonth) {
        let currentExpense = expense ?? Expense(context: context)
        
        if expense == nil {
            currentExpense.id = UUID()
        }
        
        currentExpense.title = title
        currentExpense.amount = amount
        currentExpense.category = category.rawValue
        currentExpense.month = month.rawValue
        
        saveContext()
    }
    
    func deleteExpense(expense: Expense) {
        context.delete(expense)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
            fetchExpenses()
        } catch {
            print("Erro ao salvar: \(error)")
        }
    }
}
