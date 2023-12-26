//
//  Thumbnails.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 24/12/23.
//

import Foundation

struct Thumbnails {
  let `default`: ThumbnailsDetailsModel
  let medium: ThumbnailsDetailsModel
  let high: ThumbnailsDetailsModel
  let standard: ThumbnailsDetailsModel
}

struct ThumbnailsDetailsModel {
  let url: String
}
