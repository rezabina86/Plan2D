//
//  ParameterEncoding.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

public typealias Parameters = [String : Any]

public protocol JSONBodyEncoder {
    static func encode(urlRequest: inout URLRequest, with bodyModel: Encodable) throws
}

public protocol URLEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
