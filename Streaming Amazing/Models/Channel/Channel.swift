//
//  Channel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 25/12/23.
//

import Foundation

struct Channel: Codable {
  let items: [Items]
}

struct Items: Codable {
  let id: String
  let snippet: Snippet
  let statistics: StatisticsChannel
}

struct Snippet: Codable {
  let title: String
  let description: String
  let customUrl: String
  let publishedAt: String
  let thumbnails: ThumbnailsVideo
}

struct StatisticsChannel: Codable {
  let subscriberCount: String
}
