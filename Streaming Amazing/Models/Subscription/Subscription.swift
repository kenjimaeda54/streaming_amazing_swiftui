//
//  Subscription.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 24/12/23.
//

import Foundation

struct Subscription {
  let items: [ItensSubscription]
}

struct ItensSubscription: Identifiable {
  let id: String
  let snippet: SnippetSubscription
}

struct SnippetSubscription {
  let title: String
  let thumbnails: Thumbnails
  let resourceId: ResourceId
}

struct ResourceId {
  let channelId: String
}
