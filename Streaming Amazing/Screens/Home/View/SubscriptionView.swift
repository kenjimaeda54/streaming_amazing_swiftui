//
//  SubscriptionView.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 24/12/23.
//

import SwiftUI

struct SubscriptionView: View {
  let itenSubscription: ItensSubscription
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: itenSubscription.snippet.thumbnails.medium.url)) { phase in
        if let photo = phase.image {
          photo.resizable().frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 30))
        }
      }
      Text(itenSubscription.snippet.title)
        .font(.custom(FontsApp.latoLight, size: 15))
        .foregroundStyle(.black100)
        .lineLimit(1)
    }
    .frame(width: 75)
  }
}

#Preview {
  SubscriptionView(itenSubscription: subscriptionDataMock.items[0])
}
