//
//  TableComponentSeparator.swift
//  Essentia
//
//  Created by Pavlo Boiko on 12.08.18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import UIKit

class TableComponentSeparator: UITableViewCell {
    
    private lazy var colorProvider: AppColorInterface = inject()
    public let separatorView = UIView()
    
    override public var separatorInset: UIEdgeInsets {
        didSet {
            updateSeparatorInset()
        }
    }
    
    private func updateSeparatorInset() {
        let px: CGFloat = 1.0 / UIScreen.main.scale
        separatorView.frame = CGRect(x: separatorInset.left, y: contentView.bounds.height - px, width: contentView.bounds.width - separatorInset.left - separatorInset.right, height: px)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        separatorView.backgroundColor = colorProvider.separatorBackgroundColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Laying out Subviews
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if separatorView.superview != contentView {
            contentView.addSubview(separatorView)
            separatorView.autoresizingMask = .flexibleWidth
            updateSeparatorInset()
        }
    }
}
