//
//  ViodeosWithChannelModel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 25/12/23.
//

import Foundation

class VideosWithChannelModel: ObservableObject {
  @Published var loading = LoadingState.loading
  @Published var videosWitchChannelModel: [VideosWithChannel] = []
  var httpClient = HttpClient()

  func fetchVideosWitchChannelModel() async {
    await httpClient.fetchVideoWithChannel { result in

      switch result {
      case .failure:

        DispatchQueue.main.async {
          self.loading = .failure
        }

      case let .success(channelWithVideo):

        DispatchQueue.main.async {
          self.loading = .success
          self.videosWitchChannelModel.append(channelWithVideo)
        }
      }
    }
  }
}
