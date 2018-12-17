//
//  BalanceFormatter.swift
//  Essentia
//
//  Created by Pavlo Boiko on 10/12/18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import Foundation
import HDWalletKit

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

fileprivate enum CurrencySimpolPosition {
    case prefix
    case suffix
}

final class BalanceFormatter {
    private let balanceFormatter: NumberFormatter
    private var currencySymbol: String
    private var symbolPossition: CurrencySimpolPosition
    
    convenience init(currency: FiatCurrency) {
        self.init()
        balanceFormatter.maximumFractionDigits = 2
        symbolPossition = .prefix
        currencySymbol = currency.symbol
    }
    
    convenience init(asset: AssetInterface) {
        self.init()
        currencySymbol = asset.symbol
        symbolPossition = .suffix
        balanceFormatter.minimumFractionDigits = 1
        balanceFormatter.maximumFractionDigits = 8
    }
    
    private init() {
        balanceFormatter = NumberFormatter()
        balanceFormatter.numberStyle = .currency
        balanceFormatter.currencyGroupingSeparator = ","
        balanceFormatter.currencySymbol = ""
        balanceFormatter.usesGroupingSeparator = true
        symbolPossition = .prefix
        currencySymbol = ""
        balanceFormatter.decimalSeparator = "."
    }
    
    func formattedAmmountWithCurrency(amount: Double?) -> String {
        let formatted = formattedAmmount(amount: amount)
        switch symbolPossition {
        case .prefix:
            return currencySymbol + formatted
        case .suffix:
            return formatted + " " + currencySymbol.uppercased()
        }
    }
    
    func formattedAmmountWithCurrency(ammount: String) -> String {
        return formattedAmmountWithCurrency(amount: Double(ammount))
    }
    
    func formattedAmmount(amount: Double?) -> String {
        let amount = amount ?? 0
        return balanceFormatter.string(for: amount) ?? "0"
    }
    
    func formattedAmmount(ammount: String) -> String {
        return formattedAmmount(amount: Double(ammount))
    }
    
    func attributed(amount: Double?, type: TransactionType) -> NSAttributedString {
        let formattedAmmount = self.formattedAmmountWithCurrency(amount: amount)
        let separeted = formattedAmmount.split(separator: " ")
        guard separeted.count == 2 else { return NSAttributedString() }
        let attributed = NSMutableAttributedString(string: String(separeted[0]),
                                                   attributes: [NSAttributedString.Key.font: AppFont.bold.withSize(15)])
        attributed.append(NSAttributedString(string: " "))
        attributed.append(NSAttributedString(string: String(separeted[1]),
                                             attributes: [NSAttributedString.Key.font: AppFont.regular.withSize(15)]))
        switch type {
        case .recive:
            attributed.addAttributes([NSAttributedString.Key.foregroundColor: RGB(59, 207, 85)], range: NSRange(location: 0, length: attributed.length))
        case .send:
            print("Send")
        case .exchange:
            print("Exchange")
        }
        return attributed
    }
    
    func attributedHex(amount: String, type: TransactionType) -> NSAttributedString {
        guard let wei = BInt(amount, radix: 10),
              let etherAmmount = try? WeiEthterConverter.toEther(wei: wei) else {
            return NSAttributedString()
        }
        return attributed(amount: (etherAmmount as NSDecimalNumber).doubleValue, type: type)
    }
    
    func attributedHex(amount: String, type: TransactionType, decimals: Int) -> NSAttributedString {
        guard let convertedAmmount = try? WeiEthterConverter.toToken(balance: amount, decimals: decimals, radix: 10) else {
                return NSAttributedString()
        }
        return attributed(amount: (convertedAmmount as NSDecimalNumber).doubleValue, type: type)
    }
}
