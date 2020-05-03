//
//  NetworkError.swift
//  UnsplashViewer
//
//  Created by Reza Bina on 2020-04-25.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil  = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL     = "URL is nil"
}
