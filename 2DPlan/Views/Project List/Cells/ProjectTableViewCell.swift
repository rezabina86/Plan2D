//
//  ProjectTableViewCell.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-05-03.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    private let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let nameLabel: H1 = {
        let label = H1()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let floorName: H2 = {
        let label = H2()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var project: ProjectItemsBusinessModel.Fetch.Response? {
        willSet {
            nameLabel.text = newValue?.items.first?.name
            floorName.text = newValue?.floor?.name
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            holderView.backgroundColor = .systemGray4
        } else {
            holderView.backgroundColor = .clear
        }
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        addSubview(holderView)
        holderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        holderView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        holderView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        holderView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -8).isActive = true
        
        addSubview(floorName)
        floorName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
        floorName.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -8).isActive = true
        floorName.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 8).isActive = true
        floorName.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -8).isActive = true
    }

}
