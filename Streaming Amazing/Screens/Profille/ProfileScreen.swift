//
//  ProfileScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import SwiftUI

struct ProfileScreen: View {
  @EnvironmentObject var userAuthenticationEnvironment: UserAuthenticationModel
  @StateObject private var userAuthenticationModel = UserAuthenticationModel()
  @State private var isPresented = false
  @Binding var isLoggedIn: Bool

  func handleSingOut() {
    isLoggedIn = false
    userAuthenticationModel.signOut()
    isPresented = true
  }

  var body: some View {
    VStack(alignment: .center, spacing: 14) {
      AsyncImage(url: URL(
        string: userAuthenticationEnvironment.user.user
          .photo ?? "https://github.com/kenjimaeda54.png"
      )) { phase in
        if let photo = phase.image {
          photo
            .resizable()
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 40))
        }
      }
      TitleAndSubTitle(title: "Nome", subTitle: userAuthenticationEnvironment.user.user.givenName ?? "")

      TitleAndSubTitle(title: "Email", subTitle: userAuthenticationEnvironment.user.user.email ?? "")

      Button(action: handleSingOut) {
        Text("Sair")
          .font(.custom(FontsApp.latoRegular, size: 20))
          .foregroundStyle(.red)
      }
      .padding(.top, 50)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.leading, 15)
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    .navigationDestination(isPresented: $isPresented) {
      RootScreen()
        .navigationBarBackButtonHidden()
    }
  }
}

#Preview {
  ProfileScreen(isLoggedIn: .constant(true)).environmentObject(UserAuthenticationModel())
}
