//
//  User.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 30/12/23.
//

import Foundation

struct User {
  var idToken: String?
  var user: UserDetails
}

struct UserDetails {
  var photo: String?
  var givenName: String?
  var email: String?
}
