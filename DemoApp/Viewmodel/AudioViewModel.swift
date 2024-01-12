//
//  AudioViewModel.swift
//  DemoApp
//
//

import SwiftUI
import AudioPlaylist
import Combine

protocol AudioInterface: AnyObject, ObservableObject {
    var playlists: [AudioPlaylistModel] { get set }
    func fetchAudio()
}

class AudioViewModel: AudioInterface {
    
    /// Storing the Publisher for holding reference until api retnr
    private var cancellables = Set<AnyCancellable>()

    /// Fire the UI changes to SPM
    @Published var playlists: [AudioPlaylistModel] = []
    
    /// Using combine the data will fetch from api and map without any completion blog
    // TODO : Declare enum to handle custom error in sink blog
    func fetchAudio() {
        APIClient().getReusableAPIPublsiher(AudioListModelFromApi.self)
            .receive(on: DispatchQueue.main) // Updating the UI in main thread
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request completed successfully.")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: { [weak self] audioItem in
                print("Received api items:")
                audioItem.items.forEach { self?.playlists.append($0.toAudioModel()) }
            })
            .store(in: &cancellables)
    }
}
