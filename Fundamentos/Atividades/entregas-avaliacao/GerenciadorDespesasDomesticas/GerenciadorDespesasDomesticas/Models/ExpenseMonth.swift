//
//  ExpenseMonth.swift
//  GerenciadorDespesasDomesticas
//
//  Created by Silva, Pedro Henrique Nieto da on 15/05/26.
//

import Foundation

enum ExpenseMonth: String, CaseIterable, Identifiable {
    case janeiro = "Janeiro"
    case fevereiro = "Fevereiro"
    case marco = "Março"
    case abril = "Abril"
    case maio = "Maio"
    case junho = "Junho"
    case julho = "Julho"
    case agosto = "Agosto"
    case setembro = "Setembro"
    case outubro = "Outubro"
    case novembro = "Novembro"
    case dezembro = "Dezembro"
    
    var id: String { self.rawValue }
}
