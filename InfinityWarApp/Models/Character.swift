//
//  Character.swift
//  InfinityWarApp
//
//  Created by Roger Silva on 28/04/2018.
//  Copyright © 2018 The Guardians Of Brotherhood. All rights reserved.
//

import Foundation

struct Character: Decodable {
    
    var id: Int
    var name: String
    var description: String
    var modified: String
    var thumbnail: Thumbnail
    var resourceUri: String
    var comics: Comic
    var series: Serie
    var stories: Storie
    var events: Event
    var urls: [Url]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case thumbnail
        case resourceUri = "resourceURI"
        case comics
        case series
        case stories
        case events
        case urls
    }
    
}
