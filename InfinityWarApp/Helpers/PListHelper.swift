//
//  PListHelper.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation

class PListHelper {
    
    func getInfo(filename: String, key: String) -> String {
        let file = Bundle.main.path(forResource: filename, ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)!
        return dictionary[key] as! String
    }
    
}
