//
//  PlaylistVideosChannelModel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 07/01/24.
//

import Foundation

class PlaylistVideosChannelModel: ObservableObject {
  @Published var loading: LoadingState = .loading
  @Published var listPlaylist: [SnippetPlayList] = []
  var httpClient = HttpClient()

  func fetchPlayListsVideosChannel(channelId: String) async {
    await httpClient.fetchPlayListChannel(withChannelId: channelId) { result in

      switch result {
      case .failure:

        DispatchQueue.main.async {
          self.loading = .failure
        }

      case let .success(playListItem):

        DispatchQueue.main.async {
          self.loading = .success
          self.listPlaylist.append(playListItem.items.first!.snippet)
        }
      }
    }
  }
}
