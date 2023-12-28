//
//  HomeScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import SwiftUI

struct HomeScreen: View {
  @StateObject private var videosChannelModel = VideosWithChannelModel()

  var body: some View {
    VStack(alignment: .leading, spacing: 14) {
      HStack {
        AsyncImage(url: URL(string: "https://github.com/kenjimaeda54.png")) { phase in
          if let photo = phase.image {
            photo
              .resizable()
              .frame(width: 80, height: 80)
              .clipShape(RoundedRectangle(cornerRadius: 40))
          }
        }
        VStack(alignment: .leading) {
          Text("Bem vindo de volta 👋")
            .font(.custom(FontsApp.latoLight, size: 15))
            .foregroundStyle(.black100)
          Text("Alex Ferandno")
            .font(.custom(FontsApp.latoMBold, size: 18))
            .foregroundStyle(.black100)
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("Assinaturas")
        .font(.custom(FontsApp.latoMBold, size: 20))
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: gridItensSubscriptions, spacing: rowSpacing, pinnedViews: []) {
          ForEach(subscriptionDataMock.items) { data in
            SubscriptionView(itenSubscription: data)
          }
        }
      }
      .frame(height: 100)

      switch videosChannelModel.loading {
      case .success:

        List(videosChannelModel.videosWitchChannelModel) { video in
          RowVideosWithChannel(videosWithChannel: video)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .padding(.trailing, 13)
        .listStyle(.inset)
        .scrollIndicators(.never)
        .frame(minWidth: 0, maxWidth: .infinity)

      case .loading:
        Text("Loading")

      case .failure:
        Text("")
      }
    }
    .padding(.leading, 15)
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    .task {
      await videosChannelModel.fetchVideosWitchChannelModel()
    }
  }
}

#Preview {
  HomeScreen()
}
