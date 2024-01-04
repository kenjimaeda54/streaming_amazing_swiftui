//
//  LiveScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import SwiftUI

struct LiveScreen: View {
  @StateObject private var videosChannelModel = VideosWithChannelModel()

  var body: some View {
    VStack(alignment: .leading, spacing: 14) {
      List(videosChannelModel.videosWitchChannelModel) { video in
        RowVideosWithChannel(videosWithChannel: video)
          .listRowInsets(EdgeInsets())
          .listRowSeparator(.hidden)
      }
      .padding(.trailing, 13)
      .listStyle(.inset)
      .scrollIndicators(.never)
      .frame(minWidth: 0, maxWidth: .infinity)
    }
    .padding(.leading, 15)
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    .task {
      await videosChannelModel.fetchVideosWitchChannelModel(true)
    }
  }
}

#Preview {
  LiveScreen()
}
