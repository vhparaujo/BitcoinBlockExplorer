//
//  BlockchainView.swift
//  TesteAPI
//
//  Created by Victor Hugo Pacheco Araujo on 16/05/23.
//

import SwiftUI

struct BlockchainView: View {
    @StateObject var viewModel = BlockchainViewModel()
    
    @EnvironmentObject var lastBlockViewModel: LastBlockViewModel
    @EnvironmentObject var currencyViewModel:  CurrencyViewModel
    
    // Search variables
    @StateObject var validateAddresses = Validate()
    @State var addressSearch: String = ""
    @State var idTransacaoSearch: String = ""
    @State var abrirModalAddress: Bool = false
    @State var abrirModalTransaction: Bool = false
    @State var idTransacaoButton: String = ""
    @State var searchText = ""
    
    var body: some View {
        
        VStack {
            ScrollView{
                blockchainView
                    .id(1)
            }
            .refreshable {
                viewModel.getFees()
                viewModel.getBlockHeader(50)
                viewModel.getMempoolData()
                viewModel.getMempoolSize()
                currencyViewModel.getCoins()
                lastBlockViewModel.getLastBlock()
            }
            
            AdViewComponent()
        }
        
        .task {
            viewModel.getFees()
            viewModel.getBlockHeader(50)
            viewModel.getMempoolData()
            viewModel.getMempoolSize()
        }
        
        .titleToolbar()
        
        .background(Color.background)
        
    }
    
    var blockchainView: some View {
        VStack {
            BitcoinPriceViewComponent()
            fees
            blockchain
            HalvingView()
                .environmentObject(viewModel)
        }
    }
    
    var blockchain: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
                    .scaleEffect(1.2)
            } else {
                MempoolBlocksView()
                    .environmentObject(viewModel)
            }
        }
    }
    
    var fees: some View {
        VStack{
            TextsFeesViewComponent()
            VStack(alignment: .center) {
                ForEach(viewModel.fees, id: \.self) { fee in
                    HStack(spacing: 17) {
                        BlockchainFeeViewComponent(fee: fee.hourFee)
                        BlockchainFeeViewComponent(fee: fee.halfHourFee)
                        BlockchainFeeViewComponent(fee: fee.fastestFee)
                    }
                }
            }
        }
        .padding(.vertical)
    }
    
}

#Preview {
    return BlockchainView()
        .environmentObject(CurrencyViewModel())
        .environmentObject(AddManager())
        .environmentObject(LastBlockViewModel())
}
