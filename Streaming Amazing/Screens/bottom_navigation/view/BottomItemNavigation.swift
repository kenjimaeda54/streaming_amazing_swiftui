//
//  BottomItemNavigation.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import SwiftUI

enum TabsTag: Int {
  case home = 1
  case live = 2
  case profile = 3
}

struct BottomItemNavigation: View {
  let handleCurrentTag: (TabsTag) -> Void
  let currentTag: TabsTag

  var body: some View {
    HStack(spacing: 0) {
      ContentButtonTabBar(handlePressButton: { handleCurrentTag(.home) }, iconBottomNavigation: {
        Image(systemName: "house")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundColor(currentTag == .home ? .white : .black100)
      }, isSelected: currentTag == .home)
      Spacer()
      ContentButtonTabBar(handlePressButton: { handleCurrentTag(.live) }, iconBottomNavigation: {
        Image(systemName: "video")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundColor(currentTag == .live ? .white : .black100)
      }, isSelected: currentTag == .live)
      Spacer()
      ContentButtonTabBar(handlePressButton: { handleCurrentTag(.profile) }, iconBottomNavigation: {
        Image(systemName: "person")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundColor(currentTag == .profile ? .white : .black100)
      }, isSelected: currentTag == .profile)
    }
    .ignoresSafeArea(.all)
    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width - 150, maxHeight: 65)
    .padding(.horizontal, 15)
    .padding(.vertical, 3)
    .background(
      ColorsApp.white
        .clipShape(RoundedRectangle(cornerRadius: 50))
        .shadow(color: .black100.opacity(0.34), radius: 6.27, x: 0, y: 5)
    )
  }
}
