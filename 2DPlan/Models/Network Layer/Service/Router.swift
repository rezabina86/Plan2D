//
//  Router.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation
import Combine

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private let session = URLSession(configuration: .default)
    
    func request(_ route: EndPoint) -> NetworkRouterCompletion {
        do {
            let request = try buildRequest(from: route)
            return session
                .dataTaskPublisher(for: request)
                .mapError({ $0 })
                .map(\.data)
                .eraseToAnyPublisher()
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }
    
}

extension Router {
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            
            switch route.task {
            case .request:
                break
            case .requestParameters(let bodyParameters, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                addAdditionalHeaders(additionalHeaders, request: &request)
            }
        } catch {
            throw error
        }
        
        if let headers = route.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    fileprivate func configureParameters(bodyParameters: Encodable?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParametersEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeader: Parameters?, request: inout URLRequest) {
        if let headers = additionalHeader {
            for (key, value) in headers {
                if let value = value as? String {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
        }
    }
    
}
