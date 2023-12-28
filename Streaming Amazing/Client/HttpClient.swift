//
//  HttpClient.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 25/12/23.
//

import Alamofire
import Combine
import Foundation

enum HttpError: Error {
  case badUrl, badResponse, errorEncondingData, noData, invalidUrl, indalidRequest
}

// trabalhando com concorrencia em swiftui
// https://www.swiftbysundell.com/articles/swift-concurrency-multiple-tasks-in-parallel/

class HttpClient {
  // tentar criar um fetchVideoWithChannel aqui, sera apenasu uma cahamda
  // referencia https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#using-alamofire-with-swift-concurrency
  // https://www.swiftbysundell.com/articles/async-and-concurrent-forEach-and-map/
  func fetchVideoWithChannel(completion: @escaping (Result<VideosWithChannel, HttpError>) -> Void) async {
    let responseVideo = await AF
      .request(
        "\(baseUrl)/search?part=snippet&relevanceLanguage=pt&maxResults=10&videoDuration=medium&type=video&regionCode=BR&key=AIzaSyAVxRrP61Dw76EUidoiPpfavIdqN62_LBw"
      )
      .cacheResponse(using: .cache).serializingDecodable(Video.self).response

    switch responseVideo.result {
    case let .success(video):

      await video.items.asyncForEach { videoItem in
        AF
          .request(
            "\(baseUrl)/channels?part=statistics&part=snippet&id=\(videoItem.snippet.channelId)&key=AIzaSyAVxRrP61Dw76EUidoiPpfavIdqN62_LBw"
          )
          .responseDecodable(of: Channel.self) { response in

            switch response.result {
            case let .success(channel):
              let channelWithVideo = VideosWithChannel(
                thumbVideo: videoItem.snippet.thumbnails.high.url,
                thumbProfileChannel: channel.items[0].snippet.thumbnails.medium.url,
                titleVideo: videoItem.snippet.title,
                publishedVideo: videoItem.snippet.publishedAt,
                id: UUID().uuidString,
                videoId: videoItem.id.videoId,
                descriptionVideo: videoItem.snippet.description,
                subscriberCountChannel: channel.items[0].statistics.subscriberCount,
                channelId: videoItem.snippet.channelId
              )

              completion(.success(channelWithVideo))
            case let .failure(error):
              debugPrint(error)
              completion(.failure(.badResponse))
            }
          }
      }

    case let .failure(error):
      debugPrint(error)
      completion(.failure(.badResponse))
    }
  }
}

// let channelWithVideo = VideosWithChannel(
//							thumbVideo: item.snippet.thumbnails.high.url,
//							thumbProfileChannel: channel.items[0].snippet.thumbnails.medium.url,
//							titleVideo: item.snippet.title,
//							publishedVideo: item.snippet.publishedAt,
//							id: UUID().uuidString,
//							videoId: item.id.videoId,
//							descriptionVideo: item.snippet.description,
//							subscriberCountChannel: channel.items[0].statistics.subscriberCount,
//							channelId: item.snippet.channelId
//						)
