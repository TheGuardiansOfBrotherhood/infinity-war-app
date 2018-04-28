//
//  Item.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation

struct Item: Decodable {
    
    var resourceUri: String
    var name: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case resourceUri = "resourceURI"
        case name
        case type
    }
    
}
