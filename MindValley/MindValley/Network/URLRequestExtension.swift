//
//  URLRequestExtension.swift
//  KnowMyProduct
//
//  Created by Basappa, Ramesh (Technosoft) on 02/04/19.
//  Copyright © 2019 Basappa, Ramesh (Technosoft). All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(request: Request) {
        self.init(url: URL.init(string: request.getFullURL())!)
        httpMethod = request.httpMethod
    }
}
