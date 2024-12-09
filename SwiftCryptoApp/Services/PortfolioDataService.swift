//
//  PortfolioDataService.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 09/12/24.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private var containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var saveEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                print("Error loading persistent store: \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC
    func updatePortoflio(coin: CoinModel, amount: Double){
        
        if let entity = saveEntities.first(where: { $0.coinId == coin.id }){
            if amount > 0 {
                updateCoin(entity: entity, amount: amount)
            }else {
                remove(entity: entity)
            }
        } else {
            addCoin(coin: coin, amount: amount)
        }
        
    }
    
    
    // MARK: PRIVATE
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            saveEntities = try container.viewContext.fetch(request)
        }catch let error {
            print("Error fetching portfolio: \(error)")
        }
    }
    
    private func addCoin(coin: CoinModel, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func updateCoin(entity: PortfolioEntity, amount: Double){
         entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving portfolio: \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
}
