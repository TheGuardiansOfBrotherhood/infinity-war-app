//
//  Event.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation

struct Event: Decodable {
    
    var available: Int
    var collectionUri: String
    var items: [Item]
    var returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available
        case collectionUri = "collectionURI"
        case items
        case returned
    }
    
}
