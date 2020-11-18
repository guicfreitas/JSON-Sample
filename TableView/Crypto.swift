//
//  Crypto.swift
//  TableView
//
//  Created by João Guilherme on 10/08/20.
//  Copyright © 2020 João Guilherme. All rights reserved.
//

import Foundation

public class Crypto {
    
    init(mercado: String, valor: Double) {
        self.mercado = mercado
        self.valor = valor
    }
    
    var mercado: String
    var valor: Double
}
