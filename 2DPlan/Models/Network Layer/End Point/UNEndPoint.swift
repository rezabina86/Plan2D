//
//  UNEndPoint.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

enum Apis {
    case getProject(request: ProjectItemsBusinessModel.Fetch.Request)
}

extension Apis: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://planner5d.com/api") else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .getProject(let model):
            return "/project/\(model.hash)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProject:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getProject:
            return .requestParameters(bodyParameters: nil, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
