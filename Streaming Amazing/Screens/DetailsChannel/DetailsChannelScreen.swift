//
//  DetailsChannelScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 07/01/24.
//

import SwiftUI

struct DetailsChannelScreen: View {
  @StateObject private var playListChannelModel = PlaylistVideosChannelModel()
  @StateObject var channelModel = ChannelModel()
  @State private var isPresented = false
  @State private var playListSelected: SnippetPlayList?
  var channel: ItensSubscription

  init(channel: ItensSubscription) {
    self.channel = channel
    UIScrollView.appearance().bounces = false // para retirar o bounce
  }

  var body: some View {
    VStack {
      HStack {
        BackButton()

        HStack {
          AsyncImage(url: URL(string: channel.snippet.thumbnails.medium.url)) { image in

            image
              .resizable()
              .frame(width: 60, height: 60)
              .clipShape(RoundedRectangle(cornerRadius: 30))
          } placeholder: {
            Text("")
          }

          Text(channel.snippet.title)
            .font(.custom(FontsApp.latoBold, size: 25))
            .foregroundStyle(.black100)
        }
        .frame(maxWidth: .infinity, alignment: .center)
      }
      .padding(.bottom, 20)
      switch playListChannelModel.loading {
      case .failure:
        Spacer()
        ZStack {
          Text("Não possui playlist de videos")
            .font(.custom(FontsApp.poppinsBlack, size: 23))
            .foregroundStyle(.black100)
        }
        Spacer()

      case .success:
        if playListChannelModel.listPlaylist.isEmpty {
          ZStack {
            Text("Nao possui playlist de videos")
              .frame(width: .infinity, height: .infinity, alignment: .center)
          }
          .frame(minWidth: 0, minHeight: 0, alignment: .center)
        } else {
          List(playListChannelModel.listPlaylist, id: \.resourceId.videoId) { item in
            RowVideoChannel(item: item)
              .listRowInsets(EdgeInsets())
              .listRowSeparator(.hidden)
              .listRowBackground(ColorsApp.gray50.opacity(0.7))
              .onTapGesture {
                isPresented = true
                playListSelected = item
                // para trabalhar com assincrono posso usar a palavara reservada  task
                //						Task {
                //
                //								 videosDetailsModel.fetchVideosDetails(videoId: item.resourceId.videoId)
                //
                //							}
              }
          }
          .listStyle(.inset)
          .scrollContentBackground(.hidden)
          .scrollIndicators(.never)
        }

      case .loading:
        PlaceHolderPlaystVideoChannel()
      }
    }
    .padding(.horizontal, 15)
    .background(
      ColorsApp.gray50.opacity(0.7)
    )
    .task {
      await playListChannelModel.fetchPlayListsVideosChannel(channelId: channel.snippet.resourceId.channelId)
      channelModel.fetchDetailsChannel(channelId: channel.snippet.resourceId.channelId)
    }
    .navigationDestination(isPresented: $isPresented) {
      if let playList = playListSelected {
        let video = VideosWithChannel(
          thumbVideo: playList.thumbnails.high.url,
          thumbProfileChannel: channel.snippet.thumbnails.medium.url,
          titleVideo: playList.title,
          publishedVideo: playList.publishedAt,
          id: playList.resourceId.videoId,
          videoId: playList.resourceId.videoId,
          descriptionVideo: playList.description,
          subscriberCountChannel: channelModel.channel.items.first!.statistics.subscriberCount,
          channelId: channel.snippet.resourceId.channelId
        )

        DetailsVideoScreen(video: video)
          .navigationBarBackButtonHidden()
      }
    }
  }
}

#Preview {
  DetailsChannelScreen(channel: subscriptionDataMock.items[0])
}
