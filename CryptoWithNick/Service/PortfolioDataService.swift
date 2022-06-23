//
//  PortfolioDataService.swift
//  CryptoWithNick
//
//  Created by Sy Lee on 2022/05/31.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("코어데이터 로딩 에러: \(error)")
            }
            self.getPortfolio()
        }
    }
    // MARK: - PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { entity -> Bool in
            return entity.coinID == coin.id
        }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        }
        else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - PRIVATE
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
          savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("포트폴리오 Entities 가져올때 에러 발생: \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("코어데이터 저장중 에러발생: \(error)")
        }
    }
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
