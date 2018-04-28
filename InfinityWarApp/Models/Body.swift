//
//  Body.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation

struct Body: Decodable {
    
    var code: Int
    var status: String
    var copyright: String
    var attributionText: String
    var attributionHtml: String
    var etag: String
    var data: Data
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHtml = "attributionHTML"
        case etag
        case data
    }
    
}
