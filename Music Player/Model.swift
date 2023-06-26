//
//  Model.swift
//  Music Player
//
//  Created by mohammad noor uddin on 13/6/23.
//

import Foundation

class Model {
    
    func getAlbums() -> ResponseData {
        // variable to capture the whole response after parsing the JSON data
        var parsedResponse: ResponseData?
        
        guard let url = URL(string: " ") else {
            return parsedResponse!
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Setting authorization header
        let token = " "
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error, data == nil {
                print(error.localizedDescription)
                return
            }
            
            do {
                // Parse the Json Data
                if let responseData = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    
                    let asset_base_url = (responseData["asset_base_url"] as? String)!
                    let albumPath = (responseData["albumPath"] as? String)!
                    let songThumbPath = (responseData["songThumbPath"] as? String)!
                    let songPath = (responseData["songPath"] as? String)!
                    

                    var albums: [Album] = []
                    var specials: [Album] = []
                    
                    // Extract the albums array
                    if let albumsArray = responseData["albums"] as? [[String: Any]] {
                        albums = self.parseJsonData(with: albumsArray)
                    }
                    
                    // Extract the specials array
                    if let specialArray = responseData["special"] as? [[String: Any]] {
                        specials = self.parseJsonData(with: specialArray)
                    }
                    
                    parsedResponse = ResponseData(asset_base_url: asset_base_url, albumPath: albumPath, songThumbPath: songThumbPath, songPath: songPath, albums: albums, specials: specials)

                }
            }
            catch {
                print("Error! Could not get songs.")
            }
            
            semaphore.signal()
            
        }.resume()
        
        semaphore.wait()

       return parsedResponse!
    }
}

extension Model {
    
    func parseJsonData(with albumsArray: [[String: Any]]) -> [Album] {
        var albums: [Album] = []
        // Access each album of albums array
        for album in albumsArray{
            // Properties
            if let albumId = album["_id"] as? String,
               let albumName = album["name"] as? String,
               let description = album["description"] as? String,
               let thumb = album["thumb"] as? String,
               let songs = album["songs"] as? [[String: Any]] {

                // Create an album object using the extracted properties
                var albumObject = Album(id: albumId, name: albumName, description: description, thumb: thumb, songs: [])

                // Access each song in the album
                for song in songs {
                    // Access the song properties
                    if let songId = song["_id"] as? String,
                       let songName = song["name"] as? String,
                       let songDescription = song["description"] as? String,
                       let songPro = song["pro"] as? Bool,
                       let songThumb = song["thumb"] as? String,
                       let songFile = song["file"] as? String {

                        // Create a song object using the extracted properties
                        let songObject = Song(id: songId, name: songName, description: songDescription, pro: songPro, thumb: songThumb, file: songFile)

                        // Add the song to the album's songs array
                        albumObject.songs.append(songObject)
                    }
                }
                albums.append(albumObject)
            }
        }
        return albums
    }
    
}
