//
//  BackButton.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 06/01/24.
//

import SwiftUI

struct BackButton: View {
  @Environment(\.dismiss) var dismiss

  func getSafeAreaTop() -> CGFloat {
    let keyWindow = UIApplication.shared.connectedScenes

        .filter { $0.activationState == .foregroundActive }

        .map { $0 as? UIWindowScene }

        .compactMap { $0 }

        .first?.windows

        .filter { $0.isKeyWindow }.first

    return (keyWindow?.safeAreaInsets.top)!
  }

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
    .frame(width: 50, height: 50)
    .padding(.top, getSafeAreaTop() + 30)
    .padding(.horizontal, 13)
  }
}

#Preview {
  BackButton()
}
