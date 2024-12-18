//
//  ContentView.swift
//  TesteAPI
//
//  Created by Victor Hugo Pacheco Araujo on 10/05/23.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        
        TabView{
            HomeView().tabItem {
                Label(ContentViewTexts.home, systemImage: "house")
            }.toolbarBackground(Color.azul, for: .tabBar)
            
            EveryBlocks().tabItem {
                Label(BlocksTexts.blocos, systemImage: "cube")
            }.toolbarBackground(Color.azul, for: .tabBar)
            
            EveryTransactions().tabItem {
                Label(TransactionsTexts.transacoesMaiusculo, systemImage: "rectangle.grid.1x2.fill")
            }.toolbarBackground(Color.azul, for: .tabBar)
            
            ConfigurationsView().tabItem {
                Label(Texts.configuracoes, systemImage: "gearshape.fill")
            }.toolbarBackground(Color.azul, for: .tabBar)
        }
        .accentColor(Color.laranja)
                
    }
}

#Preview {
    let addManager = AddManager()
    let currencyViewModel = CurrencyComponentViewModel()
    return ContentView()
        .environmentObject(addManager)
        .environmentObject(currencyViewModel)
}
