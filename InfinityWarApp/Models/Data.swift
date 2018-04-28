//
//  Data.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation

struct Data: Decodable {
    
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Character]
    
}
