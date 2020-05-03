//
//  NetworkManager.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Combine
import Foundation

struct NetworkManager {
    
    private let router = Router<Apis>()
    private let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    }
    
    func getPhotosList(request: ProjectItemsBusinessModel.Fetch.Request) -> AnyPublisher<ProjectItemsBusinessModel.Fetch.Response, Error> {
        return router.request(.getProject(request: request))
            .decode(type: ProjectItemsBusinessModel.Fetch.Response.self, decoder: decoder)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
}
