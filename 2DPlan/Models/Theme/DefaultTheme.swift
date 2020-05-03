//
//  DefaultTheme.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-05-03.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

struct DefaultTheme: Theme {
    
    var backgroundColor: UIColor {
        UIColor { (trait) -> UIColor in
            return trait.userInterfaceStyle == .dark ? .black : .white
        }
    }
    
    var textColor: UIColor {
        UIColor { (trait) -> UIColor in
            return trait.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
}
