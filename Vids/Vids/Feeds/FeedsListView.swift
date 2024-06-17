//
//  FeedsListView.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import SwiftUI
import AVKit

struct FeedsListView: View {
    @ObservedObject var viewModel: FeedsListViewModel = FeedsListViewModel()
    var body: some View {
        if let error = viewModel.error {
            VStack(spacing: 8) {
                Image(systemName: "wifi.exclamationmark").foregroundColor(.gray).font(.system(size: 60))
                Text(error.localizedDescription).foregroundColor(.gray).frame(alignment: .center)
                Button("Retry") {
                    viewModel.getVideos()
                }
            }
        } else {
            List(viewModel.videos, id: \.id) {video in
                VideoItemView(video: video)
            }.onAppear(perform: {
                viewModel.getVideos()
            })
        }
    }
}

struct VideoItemView: View {
    let video: VideoEntity
    var body: some View {
        let url = URL(string: video.hlsURL)
        HStack (spacing: 8) {
            if let url {
                VideoPlayer(player: AVPlayer(url: url)).frame(width: 50, height: 50).aspectRatio(contentMode: .fit).cornerRadius(5)
            }
            VStack(alignment: .leading, spacing: 5) {
                TextView(content: video.title, contentFontWeight: .bold)
                TextView(content: video.author.name, contentFontWeight: .semibold)
                TextView(content: video.convertDateToString(), contentFontWeight: .regular)
            }
            Spacer()
            Image(systemName: "info.circle").foregroundColor(Color("vidsPurple", bundle: Bundle.main))
        }
    }
}

struct TextView: View {
    let content: String
    let contentFontWeight: Font.Weight
    var body: some View {
        
        Text("\(content)").fontWeight(contentFontWeight).foregroundColor(Color("vidsBlack", bundle: Bundle.main))
    }
}
