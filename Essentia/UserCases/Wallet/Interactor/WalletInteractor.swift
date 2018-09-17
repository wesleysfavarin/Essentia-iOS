//
//  WalletInteractor.swift
//  Essentia
//
//  Created by Pavlo Boiko on 06.09.18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import Foundation

class WalletInteractor: WalletInteractorInterface {
    private lazy var walletService: WalletServiceInterface = inject()
    private lazy var tokenService: TokensServiceInterface = inject()
    
    func isValidWallet(_ wallet: ImportedWallet) -> Bool {
        let importdAssets = EssentiaStore.currentUser.wallet.importedWallets
        let alreadyContainWallet = importdAssets.contains {
            return $0.name == wallet.name || $0.pk == wallet.pk
        }
        return !alreadyContainWallet
    }
    
    func getCoinsList() -> [AssetInterface] {
        return Coin.allCases
    }
    
    func getTokensList(result: @escaping ([AssetInterface]) -> Void) {
        tokenService.getTokensList { (tokens) in
            result(tokens)
        }
    }
    
    func addCoinsToWallet(_ assets: [AssetInterface]) {
        guard let coins = assets as? [Coin] else { return }
        var currentlyAddedWallets = EssentiaStore.currentUser.wallet.generatedWalletsInfo
        coins.forEach { coin in
            let currentCoinAssets = currentlyAddedWallets.filter({ return $0.coin == coin })
            let nextDerivationIndex = currentCoinAssets.count
            let walletInfo = GeneratingWalletInfo(name: coin.name,
                                                  coin: coin,
                                                  derivationIndex: UInt32(nextDerivationIndex))
            currentlyAddedWallets.append(walletInfo)
        }
        EssentiaStore.currentUser.wallet.generatedWalletsInfo = currentlyAddedWallets
    }
    
    func addTokensToWallet(_ assets: [AssetInterface]) {
        guard let tokens = assets as? [Token] else { return }
        let wallets = EssentiaStore.currentUser.wallet.generatedWalletsInfo
        guard let etherWallet = wallets.first(where: { (wallet) -> Bool in
            return wallet.coin == Coin.ethereum
        }) else { return }
        tokens.forEach { token in
            let tokenAsset = TokenAsset(token: token, wallet: etherWallet)
            EssentiaStore.currentUser.wallet.tokenAssets.append(tokenAsset)
        }
        
    }
}
