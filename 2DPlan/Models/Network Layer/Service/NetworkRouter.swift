//
//  NetworkRouter.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation
import Combine

public typealias NetworkRouterCompletion = AnyPublisher<Data, Error>

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint) -> NetworkRouterCompletion
}
