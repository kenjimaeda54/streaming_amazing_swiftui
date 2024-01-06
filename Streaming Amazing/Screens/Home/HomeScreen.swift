//
//  HomeScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import SwiftUI

struct HomeScreen: View {
  @StateObject private var videosChannelModel = VideosWithChannelModel()
  @StateObject private var subscriptionModel = SubscriptionModel()
  @EnvironmentObject var userAuthentication: UserAuthenticationModel
  @State private var isPresentedDetails = false
  @State private var videoSelected: VideosWithChannel?

  var body: some View {
    VStack(alignment: .leading, spacing: 14) {
      HStack {
        AsyncImage(url: URL(
          string: userAuthentication.user.user
            .photo ?? "https://github.com/kenjimaeda54.png"
        )) { phase in
          if let photo = phase.image {
            photo
              .resizable()
              .frame(width: 60, height: 60)
              .clipShape(RoundedRectangle(cornerRadius: 30))
          }
        }
        VStack(alignment: .leading) {
          Text("Bem vindo de volta 👋")
            .font(.custom(FontsApp.latoLight, size: 15))
            .foregroundStyle(.black100)
          Text(userAuthentication.user.user.givenName ?? "")
            .font(.custom(FontsApp.latoBold, size: 18))
            .foregroundStyle(.black100)
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("Assinaturas")
        .font(.custom(FontsApp.latoBold, size: 20))

      switch subscriptionModel.loading {
      case .success:
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHGrid(rows: gridItensSubscriptions, spacing: rowSpacing, pinnedViews: []) {
            ForEach(subscriptionModel.subscription.items) { data in
              SubscriptionView(itenSubscription: data)
            }
          }
        }
        .frame(height: 100)

      case .loading:
        Text("loading")

      case .failure:
        Text("")
      }

      switch videosChannelModel.loading {
      case .success:
        List(videosChannelModel.videosWitchChannelModel) { video in
          RowVideosWithChannel(videosWithChannel: video)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .onTapGesture {
              isPresentedDetails = true
              videoSelected = video
            }
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
    .onAppear {
      subscriptionModel.fetchSubscription(token: userAuthentication.user.idToken ?? "")
    }
    .navigationDestination(isPresented: $isPresentedDetails) {
      if let video = videoSelected {
        DetailsVideoScreen(video: video)
          .navigationBarBackButtonHidden()
      }
    }
  }
}

#Preview {
  HomeScreen().environmentObject(UserAuthenticationModel())
}
