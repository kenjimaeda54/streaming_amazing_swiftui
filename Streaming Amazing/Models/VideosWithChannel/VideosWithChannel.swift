//
//  VideosWithChannel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 25/12/23.
//

import Foundation

// usar MV
// https://developer.apple.com/forums/thread/699003
// https://github.com/azamsharp/HotCoffeeMV/tree/main

struct VideosWithChannel: Identifiable, Codable {
  let thumbVideo: String
  let thumbProfileChannel: String
  let titleVideo: String
  let publishedVideo: String
  let id: String
  let videoId: String
  let descriptionVideo: String
  let subscriberCountChannel: String
  let channelId: String
}
