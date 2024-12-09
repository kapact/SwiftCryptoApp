//
//  CoinImageView.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 08/12/24.
//

import SwiftUI

struct CoinImageView: View {
    
    
    @StateObject var coinImageViewModel: CoinImageViewModel
    
    init(coin: CoinModel){
        _coinImageViewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = coinImageViewModel.coinImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if coinImageViewModel.isLoading {
                ProgressView()
            }else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(coin: DeveloperPreview.coin)
        .padding()
}
