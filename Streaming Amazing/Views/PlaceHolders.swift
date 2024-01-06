//
//  PlaceHolders.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 06/01/24.
//

import SwiftUI

struct PlaceholderAvatar: View {
  var body: some View {
    Image("profile-default")
      .resizable()
      .frame(width: 80, height: 80)
      .aspectRatio(contentMode: .fit)
      .clipShape(Circle())
      .redactShimmer(condition: true)
      .foregroundColor(ColorsApp.white.opacity(0.5))
  }
}

struct PlaceHolderVideosWithChannel: View {
  var body: some View {
    List(videosWithChannelMock) { video in
      RowVideosWithChannel(videosWithChannel: video)
    }
    .redactShimmer(condition: true)
    .foregroundStyle(.white)
  }
}

struct PlaceHolderAvatarSubscription: View {
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid(rows: gridItensSubscriptions, spacing: rowSpacing, pinnedViews: []) {
        ForEach(subscriptionDataMock.items) { data in
          SubscriptionView(itenSubscription: data)
        }
      }
    }
    .frame(height: 100)
    .redactShimmer(condition: true)
    .foregroundStyle(.white)
  }
}
