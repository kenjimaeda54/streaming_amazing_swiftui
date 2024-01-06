//
//  DoubleExtension.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 06/01/24.
//

import Foundation

extension Double {
  func rounded(toPlaces places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
