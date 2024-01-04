//
//  SubscriptionModel.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 30/12/23.
//

import Foundation

class SubscriptionModel: ObservableObject {
  @Published var loading = LoadingState.loading
  var subscription: Subscription = .init(items: [])
  var httpClient = HttpClient()

  func fetchSubscription(token: String) {
    httpClient.fetchSubscription(token: token) { result in

      switch result {
      case .failure:

        DispatchQueue.main.async {
          self.loading = .failure
        }

      case let .success(subscription):

        DispatchQueue.main.async {
          self.loading = .success
          self.subscription = subscription
        }
      }
    }
  }
}
