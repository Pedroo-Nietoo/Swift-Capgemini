//
//  DashboardView.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        Picker("Mês", selection: $viewModel.selectedMonth) {
                            ForEach(ExpenseMonth.allCases) { month in
                                Text(month.rawValue).tag(month)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.appColorRed)
                        .padding(.top)
                        
                        if let topExpense = viewModel.highestExpenseForSelectedMonth {
                            DashboardCard(title: "Maior Lançamento") {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(topExpense.title ?? "")
                                            .font(.headline)
                                        Text(topExpense.category ?? "")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text(topExpense.amount, format: .currency(code: "BRL"))
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        
                        DashboardCard(title: "Análise de Perfil de Gastos") {
                            if viewModel.expensesGroupedByCategory.isEmpty {
                                Text("Nenhum dado.")
                                    .foregroundColor(.secondary)
                            } else {
                                VStack(spacing: 12) {
                                    ForEach(viewModel.expensesGroupedByCategory, id: \.category) { item in
                                        HStack {
                                            Text(item.category)
                                                .foregroundColor(.secondary)
                                            Spacer()
                                            Text(item.total, format: .currency(code: "BRL"))
                                                .fontWeight(.medium)
                                        }
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Análise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appColorRed, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

struct DashboardCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.appColorRed)
            
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
