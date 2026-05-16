//
//  HomeView.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Picker("Mês", selection: $viewModel.selectedMonth) {
                        ForEach(ExpenseMonth.allCases) { month in
                            Text(month.rawValue).tag(month)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.white)
                    
                    Text("Total de Saídas")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(viewModel.totalForSelectedMonth, format: .currency(code: "BRL"))
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .padding(.bottom, 30)
                .background(Color.appColorRed)
                
                List {
                    if viewModel.filteredExpenses.isEmpty {
                        Text("Nenhum lançamento neste mês.")
                            .foregroundColor(.secondary)
                            .listRowBackground(Color.clear)
                    } else {
                        ForEach(viewModel.filteredExpenses) { expense in
                            NavigationLink {
                                ExpenseFormView(viewModel: viewModel, expenseToEdit: expense)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(expense.title ?? "Sem título")
                                            .font(.body)
                                            .foregroundColor(.primary)
                                            .fontWeight(.medium)
                                        
                                        Text(expense.category ?? "")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    
                                    Text("- \(expense.amount, format: .currency(code: "BRL"))")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.appColorRed)
                                }
                            }
                        }
                        .onDelete(perform: deleteExpense)
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(Color.appBackground)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Extrato")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        ExpenseFormView(viewModel: viewModel, expenseToEdit: nil)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                }
            }
            .toolbarBackground(Color.appColorRed, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    private func deleteExpense(offsets: IndexSet) {
        let expensesForMonth = viewModel.filteredExpenses
        for index in offsets {
            viewModel.deleteExpense(expense: expensesForMonth[index])
        }
    }
}
