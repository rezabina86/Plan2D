//
//  EndPointType.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
