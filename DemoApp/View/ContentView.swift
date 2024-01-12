//
//  ContentView.swift
//  DemoApp
//
//

import SwiftUI
import AudioPlaylist

struct ContentView: View {
    
    @ObservedObject private var model = AudioViewModel()

    var body: some View {
        VStack {
            AudioPlaylist(playlists: $model.playlists)
                .onAppear() {
                    model.fetchAudio()
                }
                .background(Color.black)
        }
        .background(Color.black)
        .padding()
    }
}

#Preview {
    ContentView()
}
