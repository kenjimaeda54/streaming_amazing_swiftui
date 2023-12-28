//
//  Thumbnails.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 24/12/23.
//

import Foundation

struct Thumbnails: Codable {
  let `default`: ThumbnailsDetails
  let medium: ThumbnailsDetails
  let high: ThumbnailsDetails
  let standard: ThumbnailsDetails
}

struct ThumbnailsDetails: Codable {
  let url: String
}
