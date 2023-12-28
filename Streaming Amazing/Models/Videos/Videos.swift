//
//  Videos.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 25/12/23.
//

import Foundation

struct Video: Codable {
  let items: [ItemsVideo]
}

struct ItemsVideo: Codable {
  let snippet: SnippetVideo
  let id: IdVideo
}

struct SnippetVideo: Codable {
  let publishedAt: String
  let title: String
  let description: String
  let thumbnails: ThumbnailsVideo
  let channelTitle: String
  let channelId: String
}

struct ThumbnailsVideo: Codable {
  let `default`: ThumbnailsDetailsVideo
  let medium: ThumbnailsDetailsVideo
  let high: ThumbnailsDetailsVideo
}

struct ThumbnailsDetailsVideo: Codable {
  let url: String
}

struct IdVideo: Codable {
  let kind: String
  let videoId: String
}
