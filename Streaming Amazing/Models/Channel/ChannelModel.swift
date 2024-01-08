//
//  ChannelModel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 07/01/24.
//

import Foundation

class ChannelModel: ObservableObject {
  @Published var loading: LoadingState = .loading
  var channel: Channel = .init(items: [])
  private var httpClient = HttpClient()

  func fetchDetailsChannel(channelId: String) {
    httpClient.fetchDetailsSingleChannel(witchChannelId: channelId) { result in

      switch result {
      case let .success(channel):
        DispatchQueue.main.async {
          self.loading = .success
          self.channel = channel
        }

      case .failure:

        DispatchQueue.main.async {
          self.loading = .failure
        }
      }
    }
  }
}
