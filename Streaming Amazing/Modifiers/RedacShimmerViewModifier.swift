//
//  RedacShimmerViewModifier.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 06/01/24.
//

import Foundation
import SwiftUI

public struct RedactAndShimmerView: ViewModifier {
  private let condition: Bool

  init(condition: Bool) {
    self.condition = condition
  }

  public func body(content: Content) -> some View {
    if condition {
      content
        .redacted(reason: .placeholder)
        .shimmering()
    } else {
      content
    }
  }
}

public extension View {
  func redactShimmer(condition: Bool) -> some View {
    modifier(RedactAndShimmerView(condition: condition))
  }
}
