//
//  MnemonicProviderInterface.swift
//  Essentia
//
//  Created by Pavlo Boiko on 19.07.18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import Foundation

protocol MnemonicProviderInterface {
    func generateMnemonic() -> String
}
