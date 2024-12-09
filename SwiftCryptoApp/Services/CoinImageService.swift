//
//  CoinImageService.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 08/12/24.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    @Published var coinImage: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName: String = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage =  fileManager.getImage(imageName: imageName, folderName: folderName){
            coinImage = savedImage
            print("Retrieved saved image from db")
        }else{
            downloadCoinImage()
            
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(from: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self, let downloadedImage = returnedImage else { return }
                self.coinImage = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}
