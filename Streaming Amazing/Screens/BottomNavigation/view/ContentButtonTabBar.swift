//
//  ContentButtonTabBar.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import SwiftUI

struct ContentButtonTabBar<IconNavigation: View>: View {
  let handlePressButton: () -> Void
  var iconBottomNavigation: () -> IconNavigation
  var isSelected: Bool

  var body: some View {
    Button(action: handlePressButton) {
      if isSelected {
        iconBottomNavigation()
          .background(
            Circle()
              .frame(width: 50, height: 50)
              .padding(7)
              .foregroundColor(.black100)
          )
      } else {
        iconBottomNavigation()
      }
    }
  }
}
