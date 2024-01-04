//
//  SigInScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 30/12/23.
//

import SwiftUI

struct SigInScreen: View {
  @StateObject private var userAuthenticationModel = UserAuthenticationModel()
  @State private var presentedRootScreen = false
  @Binding var isLoggedIn: Bool

  var body: some View {
    ZStack {
      Color.clear.overlay {
        AsyncImage(
          url: URL(
            string: "https://images.unsplash.com/photo-1638389746768-fd3020d35add?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
          )
        ) { phase in

          if let image = phase.image {
            image
              .resizable()
              .aspectRatio(1, contentMode: .fill) // manter a iamgem estica sem zoom
          }
        }
      } // usa isto para respeitar os paddings abiaxo

      VStack {
        Text("Streaming Amazing")
          .font(.custom(FontsApp.poppinsBold, size: 23))
          .foregroundStyle(ColorsApp.white)
          .shadow(color: ColorsApp.black100.opacity(0.32), radius: 5.46, x: 0, y: 4)
        Text(
          "Seu aplicativo de streaming de vídeos.\nEste aplicativo e independente usamos sua conta do Youtube para personalizar sua experiência"
        )
        .fontWithLineHeight(font: UIFont(name: FontsApp.latoRegular, size: 20)!, lineHeight: 32)
        .foregroundStyle(ColorsApp.white)
        .shadow(color: ColorsApp.black100.opacity(0.32), radius: 5.46, x: 0, y: 4)
      }
      .padding(.horizontal, 5)
    }
    .ignoresSafeArea(.all)
    .safeAreaInset(edge: .bottom) {
      Button(action: { userAuthenticationModel.sigIn() }) {
        HStack {
          Spacer()
          Text("Vamos começar")
            .font(.custom(FontsApp.latoLight, size: 15))
            .foregroundStyle(.black100)
            .padding(.vertical, 15)
          Spacer()
        }
      }
      .background(
        RoundedRectangle(cornerRadius: 20)
          .padding(.horizontal, 13)
          .foregroundStyle(.white)
      )
      .onReceive(userAuthenticationModel.$user, perform: { user in
        if !user.idToken!.isEmpty {
          presentedRootScreen = true
          isLoggedIn = true
        }

      }) // nao estamos conseguindo navegar
      .navigationDestination(isPresented: $presentedRootScreen) {
        RootScreen()
      }
    }
  }
}

#Preview {
  SigInScreen(isLoggedIn: .constant(false))
}
