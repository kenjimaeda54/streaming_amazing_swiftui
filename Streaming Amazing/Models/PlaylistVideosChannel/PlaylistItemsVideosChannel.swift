//
//  PlaylistItemsVideosChannel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 07/01/24.
//

import Foundation

struct PlaylistItemsVideosChannel: Codable {
  let items: [ItensPlayList]
}

struct ItensPlayList: Codable {
  let snippet: SnippetPlayList
  let id: String
}

struct SnippetPlayList: Codable {
  let title: String
  let description: String
  let publishedAt: String
  let thumbnails: Thumbnails
  let channelTitle: String
  let resourceId: ResourceIdPlaylist
}

struct ResourceIdPlaylist: Codable {
  let videoId: String
}
