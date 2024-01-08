//
//  PlaylistIdsVideosChannel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 07/01/24.
//

import Foundation

struct PlaylistIdsVideosChannel: Codable {
  let items: [IdsVideosPlaylist]
}

struct IdsVideosPlaylist: Codable {
  let id: String
}
