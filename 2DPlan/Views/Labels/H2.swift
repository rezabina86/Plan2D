//
//  H2.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-05-03.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class H2: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.textColor = ThemeManager.shared.theme.textColor
        self.font = UIFont.PLNFonts.H2Font
        self.numberOfLines = 0
    }

}
