//
//  RowVideosWithChannel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 25/12/23.
//

import SwiftUI

struct RowVideosWithChannel: View {
  let videosWithChannel: VideosWithChannel

  var body: some View {
    VStack {
      AsyncImage(url: URL(string: videosWithChannel.thumbVideo)) { phase in
        if let photo = phase.image {
          photo
            .resizable()
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        HStack {
          AsyncImage(url: URL(string: videosWithChannel.thumbProfileChannel)) { phase in
            if let photo = phase.image {
              photo
                .resizable()
                .scaledToFit()
                .frame(height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
          }
          Text(videosWithChannel.titleVideo)
            .lineLimit(2)
            .font(.custom(FontsApp.latoRegular, size: 18))
            .foregroundStyle(.black100)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      }
      .padding(.vertical, 15)
    }
  }
}

#Preview {
  RowVideosWithChannel(videosWithChannel: videosWithChannelMock[0])
}
