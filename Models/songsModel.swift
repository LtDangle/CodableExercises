//
//  songsModel.swift
//  CodableExercises
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class Song {
    let song_id:        String
    let song_name:      String
    let artist_id:      String?
    let display_artist: String
    let spotify_id:     String?
    
    init(song_id: String, song_name: String, artist_id: String?, display_artist: String,
         spotify_id: String?) {
        self.song_id = song_id
        self.song_name = song_name
        self.artist_id = artist_id
        self.display_artist = display_artist
        self.spotify_id = spotify_id
    }
    
    convenience init?(from songDict: [String: String?]) {
        guard
            let song_ido =  songDict["song_id"],
            let song_nameo = songDict["song_name"],
            let artist_id = songDict["artist_id"],
            let display_artisto = songDict["display_artist"],
            let spotify_id = songDict["spotify_id"]
            else {
                return nil
        }
        guard
            let song_id = song_ido,
            let song_name = song_nameo,
            let display_artist = display_artisto
            else {
                return nil
        }
        self.init(song_id: song_id, song_name: song_name, artist_id: artist_id, display_artist: display_artist, spotify_id: spotify_id)
    }
    
    static func getSongs(from data: Data) -> [Song] {
        var songArr = [Song]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let songArrOfDict = json as? [[String: String?]] else {return []}
            for songDict in songArrOfDict {
                if let song = Song(from: songDict) {
                    songArr.append(song)
                } else {
                    print("yup")
                }
            }
        }
        catch {
            print("Error serializating data")
        }
        return songArr
    }
}

extension Song: SubCellInfo {
    var textLabelText: String { return self.song_name }
    var detailTextLabelText: String { return self.display_artist}
    var imagePath: String? { return nil }
}

