//
//  AppColorInterface.swift
//  Essentia
//
//  Created by Pavlo Boiko on 12.07.18.
//  Copyright © 2018 Essentia-One. All rights reserved.
//

import UIKit

protocol AppColorInterface {
    var appBackgroundColor: UIColor { get }
    var appTitleColor: UIColor { get }
    var appDefaultTextColor: UIColor { get }
    var appLinkTextColor: UIColor { get }
    // MARK: - Backup
    var centeredButtonBackgroudColor: UIColor { get }
    var centeredButtonDisabledBackgroudColor: UIColor { get }
    var centeredButtonTextColor: UIColor { get }
    var borderedButtonTextColor: UIColor { get }
    var borderedButtonBorderColor: UIColor { get }
    var copyButtonBackgroundDeselectedColor: UIColor { get }
    var copyButtonBackgroundSelectedColor: UIColor { get }
    var copyButtonTextColor: UIColor { get }
    var blueBorderColor: UIColor { get }
    var currentWordEmpty: UIColor { get }
    var currentWordSelected: UIColor { get }
    var currentWordCurrent: UIColor { get }
    var currentWordEnteringString: UIColor { get }
    var currentWordEnteringPlaceholder: UIColor { get }
    var enteredWordBackgroud: UIColor { get }
    var enteredWordText: UIColor { get }
    // MARK: - Launchpad
    var launchpadItemTitleColor: UIColor { get }
    var launchpadItemSubTitleColor: UIColor { get }
    // MARK: - TableViewAdapter
    var settingsCellsBackround: UIColor { get }
    var separatorBackgroundColor: UIColor { get }
    var titleColor: UIColor { get }
    var accountStrengthContainerViewBackgroud: UIColor { get }
    var accountStrengthContainerViewTitles: UIColor { get }
    var accountStrengthContainerViewButtonTitle: UIColor { get }
    var settingsMenuTitle: UIColor { get }
    var settingsMenuSubtitle: UIColor { get }
    var settingsMenuSwitchAccount: UIColor { get }
    var settingsMenuLogOut: UIColor { get }
    var settingsBackgroud: UIColor { get }
}
