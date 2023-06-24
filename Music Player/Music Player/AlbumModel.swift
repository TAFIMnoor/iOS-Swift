//
//  AlbumModel.swift
//  Music Player
//
//  Created by mohammad noor uddin on 14/6/23.
//

import Foundation


struct Album: Decodable {
    var id: String
    var name: String
    var description: String
    var thumb: String
    var songs: [Song]
    
    init(id: String, name: String, description: String, thumb: String, songs: [Song]) {
        self.id = id
        self.name = name
        self.description = description
        self.thumb = thumb
        self.songs = songs
    }
}

struct Song: Decodable {
    var id: String
    var name: String
    var description: String
    var pro: Bool
    var thumb: String
    var file: String
    
    init(id: String, name: String, description: String, pro: Bool, thumb: String, file: String) {
        self.id = id
        self.name = name
        self.description = description
        self.pro = pro
        self.thumb = thumb
        self.file = file
    }
}

struct ResponseData: Decodable {
    var asset_base_url: String
    var albumPath: String
    var songThumbPath: String
    var songPath: String
    var albums: [Album]
    var specials: [Album]
    
    init(asset_base_url: String, albumPath: String, songThumbPath: String, songPath: String, albums: [Album], specials: [Album]) {
        self.asset_base_url = asset_base_url
        self.albumPath = albumPath
        self.songThumbPath = songThumbPath
        self.songPath = songPath
        self.albums = albums
        self.specials = specials
    }
}
