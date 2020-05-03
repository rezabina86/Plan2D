//
//  ProjectsStore.swift
//  2DPlan
//
//  Created by Reza Bina on 2020-04-30.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation
import Combine

final class ProjectsStore: ObservableObject {
    
    @Published private(set) var projectList: [ProjectItemsBusinessModel.Fetch.Response] = []
    @Published private(set) var error: Error?
    
    private var isProjectsLoaded: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    private let networkManager: NetworkManager
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    public func fetchAll() {
        guard !isProjectsLoaded else { return }
        fetch(hash: "bc150ea56d0f8f0896337154543136d7")
        fetch(hash: "5223bd1bf0d8232b312edbe254ece79a")
        fetch(hash: "f47a1763c2149eaf714c05fba310c342")
        fetch(hash: "11dda46aee205807f0a1c4c3e1002c0c")
    }
    
    private func fetch(hash: String) {
        networkManager
            .getPhotosList(request: ProjectItemsBusinessModel.Fetch.Request(hash: hash))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                    print(error)
                case .finished:
                    break
                }
            }) { [weak self] (project) in
                self?.projectList.append(project)
                self?.isProjectsLoaded = true
        }.store(in: &cancellables)
    }
    
}
