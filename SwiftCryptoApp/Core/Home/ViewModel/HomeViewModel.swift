//
//  HomeViewModel.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 07/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var stats: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText.combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text, startingCoins) -> [CoinModel] in
                return self.filterCoins(startingCoins, text: text)
            }.sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }.store(in: &cancellables)
        
        $allCoins.combineLatest(portfolioDataService.$saveEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }.store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.stats = returnedStats
                self?.isLoading = false
            }.store(in: &cancellables)
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortoflio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterCoins(_ startingCoins: [CoinModel], text: String) -> [CoinModel] {
        guard !text.isEmpty else { return startingCoins }
        
        let lowercasedText = text.lowercased()
        return startingCoins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(coins: [CoinModel], portfolioEntites: [PortfolioEntity]) -> [CoinModel]{
        coins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntites.first(where: { $0.coinId == coin.id }) else { return nil }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(_ marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volumn)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue = portfolioCoins.map { $0.currentHoldingsValue }.reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            guard let priceChangePercentage24H = coin.priceChangePercentage24H else { return currentValue }
            let percentageChange = priceChangePercentage24H / 100
            let priceBefore24H = currentValue / (1 + percentageChange)
            return priceBefore24H
        }.reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let porfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrentWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            porfolio
        ])
        
        return stats
    }
}
