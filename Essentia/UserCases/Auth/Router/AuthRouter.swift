//
//  AuthRouter.swift
//  Essentia
//
//  Created by Pavlo Boiko on 26.07.18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import UIKit

fileprivate enum AuthRoutes {
    case warning
    case phraseCopy(mnemonic: String)
    case phraseConfirm(mnemonic: String)
    case mnemonicLogin
    case seedAuth(auth: AuthType)
    case keyStorePassword(auth: AuthType)
    case keyStoreWarning
    
    var controller: UIViewController {
        switch self {
        case .warning:
            return WarningViewContrller()
        case .phraseCopy(let mnemonic):
            return MnemonicPhraseCopyViewController(mnemonic: mnemonic)
        case .phraseConfirm(let mnemonic):
            return MnemonicPhraseConfirmViewController(mnemonic: mnemonic)
        case .seedAuth(let auth):
            return SeedCopyViewController(auth)
        case .keyStorePassword(let auth):
            return KeyStorePasswordViewController(auth)
        case .keyStoreWarning:
            return KeyStoreWarningViewController()
        case .mnemonicLogin:
            return MnemonicPhraseConfirmViewController()
        }
    }
}

class AuthRouter: AuthRouterInterface {
    let navigationController: UINavigationController
    fileprivate let routes: [AuthRoutes]
    var current: Int = 0
    required init(navigationController: UINavigationController, type: BackupType, auth: AuthType) {
        self.navigationController = navigationController
        switch auth {
        case .backup:
            switch type {
            case .mnemonic:
                guard let mnemonic = EssentiaStore.currentUser.mnemonic else {
                    routes = []
                    break
                }
                routes = [
                    .warning,
                    .phraseCopy(mnemonic: mnemonic),
                    .phraseConfirm(mnemonic: mnemonic)
                ]
            case .seed:
                routes = [
                    .warning,
                    .seedAuth(auth:auth)
                ]
            case .keystore:
                routes = [
                    .keyStoreWarning,
                    .keyStorePassword(auth: auth)
                ]
            default: routes = []
            }
        case .login:
            switch type {
            case .mnemonic:
                routes = [
                    .mnemonicLogin
                ]
            case .seed:
                routes = [
                    .seedAuth(auth:auth)
                ]
            case .keystore:
                routes = [
                    .keyStorePassword(auth: auth)
                ]
            default: routes = []
            }
        }
        self.navigationController.pushViewController(routes.first!.controller, animated: true)
    }
    
    func showNext() {
        current++
        guard current != routes.count else {
            navigationController.popToRootViewController(animated: true)
            relese(self as AuthRouterInterface)
            return
        }
        let nextController = routes[current].controller
        navigationController.pushViewController(nextController, animated: true)
    }
    
    func showPrev() {
        current--
        if navigationController.viewControllers.count == 1 {
            navigationController.view.endEditing(true)
            navigationController.dismiss(animated: true)
        } else {
            navigationController.popViewController(animated: true)
        }
        guard current >= 0 else {
            relese(self as AuthRouterInterface)
            return
        }
    }
}