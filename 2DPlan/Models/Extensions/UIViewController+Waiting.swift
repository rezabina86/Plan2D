//
//  UIViewController+Waiting.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-05-03.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import SwiftOverlays

extension UIViewController {
    
    func showWaiting() {
        self.showWaitOverlay()
    }
    
    func hideWaiting() {
        self.removeAllOverlays()
    }
    
    func showWaitingWithText(_ text: String) {
        self.showWaitOverlayWithText(text)
    }
    
}
