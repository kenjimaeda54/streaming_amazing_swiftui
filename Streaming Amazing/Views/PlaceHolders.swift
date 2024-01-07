//
//  PlaceHolders.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 06/01/24.
//

import SwiftUI

struct PlaceholderAvatar: View {
  var body: some View {
    // para dar efeito bacana faz dowloud de uma imagme cinza
    // parecido com a cor do skeleton
    Image("skeleton")
      .resizable()
      .frame(width: 60, height: 60)
      .aspectRatio(contentMode: .fit)
      .clipShape(Circle())
  }
}

struct PlaceHolderVideosWithChannel: View {
  var body: some View {
    List(videosWithChannelMock) { video in
      RowVideosWithChannel(videosWithChannel: video)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .redactShimmer(condition: true)
    }
    .padding(.trailing, 13)
    .listStyle(.inset)
    .scrollIndicators(.never)
  }
}

struct PlaceHolderImageThumbVideo: View {
  var body: some View {
    Image("skeleton")
      .resizable()
      .frame(width: .infinity, height: 250)
      .clipShape(RoundedRectangle(cornerRadius: 15))
  }
}

struct PlaceHolderAvatarSubscription: View {
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid(rows: gridItensSubscriptions, spacing: rowSpacing, pinnedViews: []) {
        ForEach(subscriptionDataMock.items) { data in
          SubscriptionView(itenSubscription: data)
            .redactShimmer(condition: true)
        }
      }
    }
  }
}

struct PlaceHolderText: View {
  var body: some View {
    Text("PlaceHolder new")
      .redactShimmer(condition: true)
  }
}

struct PlaceHolderRichText: View {
  var body: some View {
    Text(
      "PlaceHolder new,PlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder newPlaceHolder new"
    )
    .fontWithLineHeight(font: UIFont(name: FontsApp.latoRegular, size: 17)!, lineHeight: 25)
    .redactShimmer(condition: true)
  }
}

#Preview {
  PlaceHolderAvatarSubscription()
}
