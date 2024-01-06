//
//  VideoDetails.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 04/01/24.
//

import Foundation

struct VideoDetails: Codable {
  let items: [ItemsVideoDetails]
}

struct ItemsVideoDetails: Codable {
  let snippet: SnippetVideo
  let statistics: StatisticVideoDetails
}

struct StatisticVideoDetails: Codable {
  let viewCount: String
}
