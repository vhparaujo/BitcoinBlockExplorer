//
//  EveryBlocks.swift
//  TesteAPI
//
//  Created by Victor Hugo Pacheco Araujo on 16/05/23.
//

import SwiftUI

struct EveryBlocks: View {
  
  @StateObject var blockData = BlockData()
  @StateObject var validateAddresses = Validate()
  
  @State var timestamp: String = ""
  @State var numberTransactions: Int64 = 0
  @State var blockMiner: String = ""
  @State var medianFee: Double = 0
  @State var blockSize: Double = 0
  @State var heightBlock: Int = 0
  @State var hashBlock: String = ""
  
  // using the search
  @State var addressSearch: String = ""
  @State var idTransacaoSearch: String = ""
  @State var abrirModalAddress: Bool = false
  @State var abrirModalTransaction: Bool = false
  @State var abrirModal: Bool = false
  @State var idTransacaoButton: String = ""
  @State var searchText = ""
  
  // this number is only to put in the parameter of the fetch()
  let numberOfBlocks: Int = 100
  
  let colunas = [GridItem(spacing: 20), GridItem()]
  
  var body: some View {
    NavigationStack{
      ScrollView{
        VStack{
          
          HStack {
              Text(BlocksTexts.blocos)
                  .foregroundColor(Color.cinza)
                  .bold()
                  .font(.headline)
            Spacer()
          }
          
          if blockData.loading {
              ProgressView().scaleEffect(1.2)
          } else {
            
            LazyVGrid(columns: colunas, spacing: 15) {
              ForEach(blockData.blockDatas, id: \.self) { blocks in
                
                Button{
                  abrirModal.toggle()
                } label: {
                  
                  VStack{
                      let tamanho = String(format: "%.2f", (blocks.size / 1000000))
                      
                      Text("\(blocks.height)")
                          .foregroundColor(Color.laranja)
                          .font(.callout)
                      Text("~\(Int(blocks.extras.medianFee)) \(Texts.satVb)")
                          .foregroundColor(Color.cinza)
                          .font(.footnote)
                      Text("\(tamanho) \(BlocksTexts.MB)")
                          .foregroundColor(Color.cinza)
                          .font(.footnote)
                      Text("\(blocks.tx_count) \(TransactionsTexts.transacoes)").foregroundColor(Color.cinza)
                          .font(.footnote)
                      Text("\(blocks.formatTimestamp(blocks.timestamp))")
                          .foregroundColor(Color.cinza)
                          .font(.footnote)
                  }.padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: 109)
                    .background(Color.caixas)
                    .cornerRadius(7)
                  
                    .onTapGesture {
                      hashBlock = blocks.id
                      heightBlock = blocks.height
                      medianFee = blocks.extras.medianFee
                      blockSize = blocks.size
                      blockMiner = blocks.extras.pool.name
                      numberTransactions = blocks.tx_count
                      timestamp = blocks.formatTimestampWithHour(blocks.timestamp)
                      abrirModal.toggle()
                    }
                  
                }
              }
            }
          }
          
        }.padding()
      }
        
      .task {
        blockData.getBlockDatas(numberOfBlocks)
      }
        
      .refreshable {
          blockData.getBlockDatas(numberOfBlocks)
      }
      
      // sheet of eachBlock
        .sheet(isPresented: $abrirModal) {
          EachBlock(timestamp: $timestamp,numberTransactions: $numberTransactions, blockMiner: $blockMiner, medianFee: $medianFee, blockSize: $blockSize, hashBlock: $hashBlock, heightBlock: $heightBlock, abrirModal: $abrirModal)
                .presentationBackground(Color.azul)
        }
      
      // using the searchable and calling the .sheet EachTransaction here to make possible use the search too in this view
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: ToolbarTexts.searchPlaceholder) {
        }
        .onSubmit(of: .search) {
          
          if validateAddresses.isValidAddress(searchText){
            addressSearch = searchText
            abrirModalAddress.toggle()
            
          } else {
            idTransacaoSearch = searchText
            abrirModalTransaction.toggle()
          }
          
        }
        .sheet(isPresented: $abrirModalAddress ) {
          EachAddress(addressSearch: $addressSearch, abrirModalAddress: $abrirModalAddress)
                .presentationBackground(Color.azul)
        }
        .sheet(isPresented: $abrirModalTransaction) {
          EachTransaction(idTransacaoButton: $idTransacaoButton, idTransacaoSearch: $idTransacaoSearch, abrirModalTransaction: $abrirModalTransaction)
                .presentationBackground(Color.azul)
        }
      
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
              Image(ToolbarTexts.bitcoinIcone)
                  .resizable()
                  .frame(width: 40, height: 40)
          }
          ToolbarItem(placement: .principal) {
              Text(ToolbarTexts.titleOfTheApp)
                  .foregroundColor(Color.laranja)
                  .bold()
                  .font(.title3)
          }
        }
        .toolbarBackground(Color.azul, for: .navigationBar)
        .background(Color.azul)
    }
    
  }
}

struct EveryBlocks_Previews: PreviewProvider {
  static var previews: some View {
    EveryBlocks()
  }
}
