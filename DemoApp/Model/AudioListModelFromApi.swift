//
//  AudioListModelFromApi.swift
//  DemoApp
//
//

import Foundation
import AudioPlaylist

struct AudioListModelFromApi: Decodable {
    var items: [AudioItem]
}

struct AudioItem: Decodable {
    var title: String
    var thumbnail: String
    var audioUrl: String
    
    func toAudioModel() -> AudioPlaylistModel {
        return AudioPlaylistModel(title: self.title, coverImageURL: self.thumbnail, auidoURL: self.audioUrl)
    }
}
