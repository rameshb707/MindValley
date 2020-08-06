//
//  RequestType.swift
//  KnowMyProduct
//
//  Created by Basappa, Ramesh (Technosoft) on 02/04/19.
//  Copyright © 2019 Basappa, Ramesh (Technosoft). All rights reserved.
//

import Foundation

enum RequestType {
    case GET
}

// MARK: - Contains supporting Computed properties
extension RequestType {
    
    /// returns: the http method as string
    var method: String {
        switch self {
            case .GET: return "GET"
        }
    }
}

