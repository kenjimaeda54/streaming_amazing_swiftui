//
//  Constants.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 24/12/23.
//

import Foundation
import SwiftUI

let rowSpacing: CGFloat = 10
var gridItensSubscriptions: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
}
