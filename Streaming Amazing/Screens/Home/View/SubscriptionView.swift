//
//  SubscriptionView.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 24/12/23.
//

import SwiftUI

// para lidar com place holder em imagens assyncronas e bom
// ter uma imagem local no bundle,paceholderAvatar carrega ela
struct SubscriptionView: View {
  let itenSubscription: ItensSubscription
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: itenSubscription.snippet.thumbnails.medium.url)) { image in
        image.resizable().frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 30))
      } placeholder: {
        PlaceholderAvatar()
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
