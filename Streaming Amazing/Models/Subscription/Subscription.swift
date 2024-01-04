//
//  Subscription.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 24/12/23.
//

import Foundation

struct Subscription: Codable {
  let items: [ItensSubscription]
}

struct ItensSubscription: Identifiable, Codable {
  let id: String
  let snippet: SnippetSubscription
}

struct SnippetSubscription: Codable {
  let title: String
  let thumbnails: ThumbnailsSubscription
  let resourceId: ResourceId
}

struct ResourceId: Codable {
  let channelId: String
}

struct ThumbnailsSubscription: Codable {
  let `default`: ThumbnailsDetails
  let medium: ThumbnailsDetails
  let high: ThumbnailsDetails
}
