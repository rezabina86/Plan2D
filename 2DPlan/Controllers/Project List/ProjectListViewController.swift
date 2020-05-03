//
//  ProjectListViewController.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-04-30.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit
import Combine

class ProjectListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = UIView(frame: CGRect.zero)
        view.separatorStyle = .none
        return view
    }()
    
    private var store: ProjectsStore!
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var projects: [ProjectItemsBusinessModel.Fetch.Response] = [] {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubscribers()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.fetchAll()
    }
    
    private func setupViews() {
        view.backgroundColor = ThemeManager.shared.theme.backgroundColor
        navigationItem.title = "Projects"
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupSubscribers() {
        store = ProjectsStore()
        
        store.$projectList.sink { [weak self] (projects) in
            self?.projects = projects
        }.store(in: &cancellables)
        
        store.$error.sink { (error) in
            
        }.store(in: &cancellables)
    }
    
}

extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let project = projects[indexPath.row]
        let detailController = ProjectPlanViewController()
        detailController.project = project
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension ProjectListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProjectTableViewCell()
        cell.project = projects[indexPath.row]
        return cell
    }
}
