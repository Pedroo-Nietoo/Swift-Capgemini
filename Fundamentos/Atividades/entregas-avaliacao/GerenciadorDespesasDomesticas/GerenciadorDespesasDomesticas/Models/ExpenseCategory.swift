//
//  ExpenseCategory.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import Foundation

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case energia = "Energia"
    case internet = "Internet"
    case agua = "Água"
    case assinaturas = "Assinaturas"
    case aluguel = "Aluguel"
    case mercado = "Mercado"
    case cursos = "Cursos"
    case lazer = "Lazer"
    
    var id: String { self.rawValue }
}
