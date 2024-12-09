//
//  CoinImageViewModel.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 08/12/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var coinImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    
    init (coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers(){
        dataService.$coinImage
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.coinImage = returnedImage
            }
            .store(in: &cancellables)
    }
}
