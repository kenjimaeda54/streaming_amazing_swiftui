//
//  RootScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 23/12/23.
//

import GoogleSignIn
import SwiftUI

struct RootScreen: View {
  @State var isLoggedIn = false

  var body: some View {
    Group {
      if GIDSignIn.sharedInstance.currentUser != nil || isLoggedIn {
        BottomNavigation(isLoggedIn: $isLoggedIn)
      } else {
        SigInScreen(isLoggedIn: $isLoggedIn)
      }
    }
  }
}

#Preview {
  RootScreen()
}
