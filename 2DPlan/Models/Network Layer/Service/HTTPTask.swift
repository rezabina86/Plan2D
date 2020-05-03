//
//  HTTPTask.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String : String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Encodable?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Encodable?, urlParameters: Parameters?, additionalHeaders: Parameters?)
}
