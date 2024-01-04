//
//  ImageExtension.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 30/12/23.
//

import Foundation
import SwiftUI

extension Image {
  func centerCropped() -> some View {
    GeometryReader { geo in
      self
        .resizable()
        .scaledToFill()
        .frame(width: geo.size.width, height: geo.size.height)
        .clipped()
    }
  }
}
