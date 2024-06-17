//
//  FeedsListViewModel.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import Foundation
import Combine

class FeedsListViewModel: ObservableObject {
    @Published var videos: [VideoEntity] = []
    @Published var error: APIError?
    private let interactor: Interactor = Interactor()
    private var cancellable = Set<AnyCancellable>()
    func getVideos() {
        interactor.request(url: .videos).sink { [weak self] result in
            switch result {
            case .finished:
                self?.error = nil
            case .failure(let error):
                self?.error = error
            }
        } receiveValue: { [weak self] (value: [VideoEntity]) in
            self?.videos = value.sorted(by: { a, b in
                a.publishedAt < b.publishedAt
            })
        }.store(in: &cancellable)
    }
}
