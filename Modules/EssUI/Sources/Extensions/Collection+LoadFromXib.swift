//
//  Collection+LoadFromXib.swift
//  Essentia
//
//  Created by Pavlo Boiko on 21.07.18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    public static var identifire: String {
        return String(describing: self)
    }
}

public extension UITableViewCell {
    public static var identifire: String {
        return String(describing: self)
    }
}

public extension UICollectionView {
    public func register<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: Cell.identifire)
    }
    
    public func register<Cell: UICollectionViewCell & NibLoadable>(_ cell: Cell.Type) {
        register(Cell.nib, forCellWithReuseIdentifier: Cell.identifire)
    }
    
    public func dequeueReusableCell <Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifire, for: indexPath) as? Cell else {
            fatalError()
        }
        return cell
    }
}

public extension UITableView {
    public func register<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.identifire)
    }
    
    public func register<Cell: UITableViewCell & NibLoadable>(_ cell: Cell.Type) {
        register(Cell.nib, forCellReuseIdentifier: Cell.identifire)
    }
    
    public func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let cellIdentifire = Cell.identifire
        let cell = dequeueReusableCell(withIdentifier: cellIdentifire) as? Cell
        guard cell != nil else {
            fatalError()
        }
        return cell!
    }
    
    public func cellForRow<Cell: UITableViewCell>(at indexPath: IndexPath) -> Cell {
        guard let cell = cellForRow(at: indexPath) as? Cell else {
            fatalError()
        }
        return cell
    }
}
