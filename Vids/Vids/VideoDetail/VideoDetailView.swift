//
//  VideoDetailView.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import SwiftUI
import MarkdownKit
import AVKit

struct VideoDetailView: View {
    @ObservedObject var viewModel: VideoDetailViewModel
    @State private var isPlaying = false
    @State private var showControls = true
    @State private var player = AVPlayer()
    @State private var url: URL?
    
    var body: some View {
        VStack {
            ZStack {
                PlayerView(player: $player, isPlaying: $isPlaying)
                    .frame(height: UIScreen.main.bounds.width * 9 / 16)
                    .onTapGesture {
                        showControls.toggle()
                    }
                if showControls {
                    HStack(spacing: 32) {
                        PlayerControlsButton(imageName: "previous", size: 40) {
                            viewModel.previousItem()
                            updatePlayerUrl()
                        }
                        if isPlaying {
                            PlayerControlsButton(imageName: "pause", size: 60) {
                                isPlaying.toggle()
                                showControls = true
                            }
                        } else {
                            PlayerControlsButton(imageName: "play", size: 60) {
                                isPlaying.toggle()
                                showControls = false
                            }
                        }
                        PlayerControlsButton(imageName: "next", size: 40) {
                            viewModel.nextItem()
                            updatePlayerUrl()
                        }
                    }
                }
            }
            List {
                DescriptionView(video: viewModel.currentVideo)
            }
            .listStyle(.plain)
            .navigationTitle(viewModel.currentVideo.title)
            .onAppear(perform: setupPlayer)
            .onDisappear(perform: {
                player.pause()
            })
        }
    }
    
    private func setupPlayer() {
        updatePlayerUrl()
    }
    
    private func updatePlayerUrl() {
        if let newUrl = viewModel.url {
            player.replaceCurrentItem(with: AVPlayerItem(url: newUrl))
        }
    }
}

struct PlayerControlsButton: View {
    let imageName: String
    let size: CGFloat
    var onTap: () -> (Void)
    var body: some View {
        Button(action: onTap){
            Image(imageName, bundle: Bundle.main).foregroundColor(.gray)
        }
        .frame(width: size,  height: size)
        .background(Color.white)
        .clipShape(.circle)
    }
}

struct DescriptionView: View {
    let video: VideoEntity
    private let parser: MarkdownParser = MarkdownParser()
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(video.title)").fontWeight(.bold)
                Text("\(video.author.name)").fontWeight(.light).foregroundColor(.gray)
            }
            let description = parser.parse(video.description)
            Text("\(description)")
            Text("Published at \(video.convertDateToString())").fontWeight(.light).font(.caption2)
        }
    }
}

struct PlayerView: UIViewControllerRepresentable {
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if isPlaying {
            player.play()
        } else {
            player.pause()
        }
    }
}

