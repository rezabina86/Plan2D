//
//  ProjectPlanViewController.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-04-30.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class ProjectPlanViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.PLNColors.blue
        return view
    }()
    
    var project: ProjectItemsBusinessModel.Fetch.Response! {
        willSet {
            navigationItem.title = newValue.items.first?.name
        }
    }
    
    private var imageViewTopConstraint: NSLayoutConstraint!
    private var imageViewBottomConstraint: NSLayoutConstraint!
    private var imageViewLeadingConstraint: NSLayoutConstraint!
    private var imageViewTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showWaiting()
        if let project = project {
            project.draw { image in
                DispatchQueue.main.async { [weak self] in
                    self?.hideWaiting()
                    self?.imageView.image = image
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / project.size.width
        let heightScale = size.height / project.size.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    func setupViews() {
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = ThemeManager.shared.theme.backgroundColor
        
        scrollView.delegate = self
        scrollView.contentSize = project.size
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(imageView)
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0)
        
        imageViewTopConstraint.isActive = true
        imageViewBottomConstraint.isActive = true
        imageViewLeadingConstraint.isActive = true
        imageViewTrailingConstraint.isActive = true
        
    }
    
}

extension ProjectPlanViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - project.size.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - project.size.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
}
