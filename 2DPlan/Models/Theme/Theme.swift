//
//  Theme.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-05-03.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

public protocol Theme: Codable {
    var backgroundColor : UIColor { get }
    var textColor: UIColor { get }
}
