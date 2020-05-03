//
//  ProjectListNavigationViewController.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-04-30.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class ProjectListNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewControllers = [ProjectListViewController()]
        interactivePopGestureRecognizer?.delegate = nil
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }

}
