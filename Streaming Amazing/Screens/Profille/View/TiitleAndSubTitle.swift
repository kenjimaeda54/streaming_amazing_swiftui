//
//  TiitleAndSubTitle.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 03/01/24.
//

import SwiftUI

struct TitleAndSubTitle: View {
  var title: String
  var subTitle: String
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .font(.custom(FontsApp.latoBold, size: 20))
        .foregroundStyle(.black100)
      Text(subTitle)
        .font(.custom(FontsApp.latoRegular, size: 17))
        .foregroundStyle(.gray100)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  TitleAndSubTitle(title: "Nome", subTitle: "Ricardo")
}
