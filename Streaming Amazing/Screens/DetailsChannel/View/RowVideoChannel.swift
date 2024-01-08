//
//  RowVideoChannel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 07/01/24.
//

import SwiftUI

struct RowVideoChannel: View {
  let item: SnippetPlayList
  var body: some View {
    VStack(alignment: .leading) {
      AsyncImage(url: URL(string: item.thumbnails.high.url)) { image in
        image
          .resizable()
          .frame(height: 250)
          .clipShape(RoundedRectangle(cornerRadius: 15))

      } placeholder: {
        PlaceHolderImageThumbVideo()
      }
      Text(item.title)
        .lineLimit(2)
        .font(.custom(FontsApp.latoRegular, size: 18))
        .foregroundStyle(.black100)
        .multilineTextAlignment(.leading)
        .padding(.bottom, 5)
      Text(item.description)
        .lineLimit(2)
        .font(.custom(FontsApp.latoRegular, size: 15))
        .foregroundStyle(.gray100)
        .multilineTextAlignment(.leading)
    }
    .padding(.bottom, 17)
  }
}
