//
//  PortfolioView.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 08/12/24.
//

import SwiftUI

struct PortfolioView: View {
        
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }

            }
            .navigationTitle("Edit Portfolio")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    XMarkButton{
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    tralingNavBarButton
                }
            }
            .onChange(of: viewModel.searchText){ newValue in
                if newValue.isEmpty {
                    removeSelectedCoin()
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel())
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 10){
                ForEach((viewModel.searchText.isEmpty && !viewModel.portfolioCoins.isEmpty)
                        ? viewModel.portfolioCoins : viewModel.allCoins){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture{
                            withAnimation(.easeIn){
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green: Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin
        if let portoflioCoins = viewModel.portfolioCoins.first{ $0.id == coin.id },
        let amount = portoflioCoins.currentHoldings{
            quantityText = "\(amount)"
        }else{
            quantityText = ""
        }
    }
    
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrentWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount holding:")
                
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrentWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var tralingNavBarButton: some View {
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            Button(action: {
                saveButtonPressed()
            }){
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText))
                ? 1: 0
            )
        }
        .font(.headline)
    }
    
    
    private func getCurrentValue() -> Double{
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed(){
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
        viewModel.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn){
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            withAnimation(.easeOut){
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
