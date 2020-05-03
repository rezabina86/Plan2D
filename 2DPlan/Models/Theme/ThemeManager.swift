//
//  ThemeManager.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-05-03.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class ThemeManager {
    
    var theme: Theme = DefaultTheme()
    
    static let shared = {
        return ThemeManager()
    }()
    
}
