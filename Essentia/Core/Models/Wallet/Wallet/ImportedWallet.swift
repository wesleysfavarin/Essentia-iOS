//
//  ImportedWallet.swift
//  Essentia
//
//  Created by Pavlo Boiko on 11.09.18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import UIKit

class ImportedWallet: Codable, WalletInterface, ViewWalletInterface {
    var address: String
    var coin: Coin
    var pk: String
    var name: String
    var lastBalance: Double?
    
    init(address: String, coin: Coin, pk: String, name: String, lastBalance: Double? = nil) {
        self.address = address
        self.coin = coin
        self.pk = pk
        self.name = name
        self.lastBalance = lastBalance
    }
    
    var symbol: String {
        return coin.symbol
    }
    
    var asset: AssetInterface {
        return coin
    }
    
    func privateKey(withSeed: String) -> String {
        return pk
    }
    
    var iconUrl: URL {
        return CoinIconsUrlFormatter(name: coin.name, size: .x128).url
    }
}
