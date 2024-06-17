//
//  VideoDetailViewModel.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import Foundation
import AVKit

class VideoDetailViewModel: ObservableObject {
    var videos: [VideoEntity]
    var currentIndex: Int
    @Published var currentVideo: VideoEntity
    @Published var url: URL?
    init(videos: [VideoEntity], currentIndex: Int, currentVideo: VideoEntity) {
        self.videos = videos
        self.currentIndex = currentIndex
        self.currentVideo = currentVideo
        self.url = URL(string: currentVideo.fullURL)
    }
    func nextItem() {
        currentIndex += 1
        if (currentIndex >= videos.count) {
            currentIndex = 0
            currentVideo = videos[currentIndex]
        } else {
            currentVideo = videos[currentIndex]
        }
        url = URL(string: currentVideo.fullURL)
    }
    func previousItem() {
        currentIndex -= 1
        if (currentIndex < 0) {
            currentIndex = videos.count - 1
            currentVideo = videos[currentIndex]
        } else {
            currentVideo = videos[currentIndex]
        }
        url = URL(string: currentVideo.fullURL)
    }
}
