//
//  BottomNavigation.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import SwiftUI

struct BottomNavigation: View {
  @State var currentTag: TabsTag = .home

  func handleCurrentTag(_ tag: TabsTag) {
    currentTag = tag
  }

  var body: some View {
    NavigationStack {
      switch currentTag {
      case .home:
        HomeScreen()
          .safeAreaInset(edge: .bottom) {
            BottomItemNavigation(handleCurrentTag: handleCurrentTag, currentTag: currentTag)
              .offset(y: -15)
          }

      case .live:
        LiveScreen()
          .safeAreaInset(edge: .bottom) {
            BottomItemNavigation(handleCurrentTag: handleCurrentTag, currentTag: currentTag)
              .offset(y: -15)
          }
      case .profile:
        ProfileScreen()
          .safeAreaInset(edge: .bottom) {
            BottomItemNavigation(handleCurrentTag: handleCurrentTag, currentTag: currentTag)
              .offset(y: -15)
          }
      }
    }
  }
}

#Preview {
  BottomNavigation()
}
