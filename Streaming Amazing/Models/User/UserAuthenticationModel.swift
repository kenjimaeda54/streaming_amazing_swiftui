//
//  UserAuthenticationModel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 30/12/23.
//

import Foundation
import GoogleSignIn

// https://paulallies.medium.com/google-sign-in-swiftui-2909e01ea4ed

class UserAuthenticationModel: ObservableObject {
  @Published var user: User = .init(idToken: "", user: UserDetails(photo: "", givenName: "", email: ""))
  @Published var isLoading = LoadingState.loading

  init() {
    checkPreviousSignIn()
  }

  func checkStatus() {
    if GIDSignIn.sharedInstance.currentUser != nil {
      let user = GIDSignIn.sharedInstance.currentUser

      guard let user = user else { return }
      self.user.idToken = user.accessToken.tokenString
      self.user.user.givenName = user.profile?.givenName ?? user.profile?.name
      self.user.user.email = user.profile?.email
      self.user.user.photo = user.profile?.imageURL(withDimension: 100)?.absoluteString
      isLoading = LoadingState.success
    } else {
      isLoading = LoadingState.failure
    }
  }

  func checkPreviousSignIn() {
    GIDSignIn.sharedInstance.restorePreviousSignIn { _, error in
      if let error = error {
        debugPrint(error.localizedDescription)
      }
    }

    checkStatus()
  }

  func sigIn() {
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?
      .rootViewController else { return }

    GIDSignIn.sharedInstance.signIn(
      withPresenting: presentingViewController,
      hint: "Usa sua conta do Google",
      additionalScopes: [
        "https://www.googleapis.com/auth/youtube.force-ssl",
        "https://www.googleapis.com/auth/youtube.channel-memberships.creator",
        "https://www.googleapis.com/auth/youtube"
      ]
    ) { _, error in

      if let error = error {
        debugPrint(error.localizedDescription)
      }

      self.checkStatus()
    }
  }

  func signOut() {
    GIDSignIn.sharedInstance.signOut()
    checkStatus()
  }
}
