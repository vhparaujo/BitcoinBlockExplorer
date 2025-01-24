//
//  Configurations.swift
//  BitcoinBlockExplorer
//
//  Created by Victor Hugo Pacheco Araujo on 20/02/24.
//

import SwiftUI

struct CurrencyViewComponent: View {
    
    var rate: Double

    @EnvironmentObject var currencyViewModel:  CurrencyComponentViewModel
    
    var body: some View {
        VStack{
            
            let priceFinal = rate * (currencyViewModel.price)
            let currentCoin = formatCoin(priceFinal, symbol: currencyViewModel.symbol ?? "")
            
            Text("\(currentCoin)")
        }
        
        .task {
            withAnimation(.bouncy) {
                currencyViewModel.getAllCoins()
            }
        }
    
    }
}

#Preview {
    let vm = CurrencyComponentViewModel()
    return CurrencyViewComponent(rate: 1)
        .environmentObject(vm)
}
