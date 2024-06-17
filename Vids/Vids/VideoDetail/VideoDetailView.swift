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
    let video: VideoEntity
    var body: some View {
        let url = URL(string: video.fullURL)
        if let url {
            PlayerView(url: url).frame(height: UIScreen.main.bounds.width * 9 / 16)
        }
        List {
            DescriptionView(video: video)
        }
        .listStyle(.plain)
        .navigationTitle("Video Player")
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
    typealias UIViewControllerType = AVPlayerViewController
    let url: URL
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let controller = AVPlayerViewController()
        controller.player = AVPlayer(url: url)
        controller.showsPlaybackControls = true
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        return
    }
}
