//
//  BackButton.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 06/01/24.
//

import SwiftUI

struct BackButton: View {
  @Environment(\.dismiss) var dismiss

  var body: some View {
    Button(action: { dismiss() }) {
      Image(systemName: "chevron.left")
        .frame(width: 30, height: 30)
        .foregroundStyle(.white)
    }
    .background(
      .ultraThinMaterial
    )
    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    .shadow(color: .black100.opacity(0.25), radius: 3.84, x: 0, y: 2)
    .frame(width: 50, height: 50)
  }
}

#Preview {
  BackButton()
}
