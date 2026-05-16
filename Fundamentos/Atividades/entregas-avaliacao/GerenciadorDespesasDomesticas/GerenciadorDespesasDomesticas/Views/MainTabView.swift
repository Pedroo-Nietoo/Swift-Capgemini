//
//  MainTabView.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import SwiftUI
internal import CoreData

struct MainTabView: View {
    @StateObject private var viewModel: ExpenseViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: ExpenseViewModel(context: context))
    }
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("Extrato", systemImage: "list.bullet.rectangle.portrait")
                }
            
            DashboardView(viewModel: viewModel)
                .tabItem {
                    Label("Análise", systemImage: "chart.pie.fill")
                }
        }
        .tint(.appColorRed)
    }
}
