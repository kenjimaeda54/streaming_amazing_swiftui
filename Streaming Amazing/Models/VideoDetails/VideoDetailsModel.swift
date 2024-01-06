//
//  VideoDetailsModel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 04/01/24.
//

import Foundation

class VideoDetailsModel: ObservableObject {
  @Published var loading = LoadingState.loading
  var videoDetails: VideoDetails = .init(items: [])
  var httpClient = HttpClient()

  func fetchVideosDetails(videoId: String) {
    httpClient.fetchDetailsVideo(completion: { result in

      switch result {
      case .failure:

        DispatchQueue.main.async {
          self.loading = .failure
        }

      case let .success(videoDetails):

        DispatchQueue.main.async {
          self.loading = .success
          self.videoDetails = videoDetails
        }
      }
    }, videoId: videoId)
  }
}
