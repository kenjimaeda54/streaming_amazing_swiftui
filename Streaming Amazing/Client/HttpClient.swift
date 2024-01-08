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
	
	//precisa inserir seu apiKey no enviroment
  var apiKey: String {
    guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else { return "" }
    return apiKey
  }

  // referencia https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#using-alamofire-with-swift-concurrency
  // https://www.swiftbysundell.com/articles/async-and-concurrent-forEach-and-map/
  func fetchVideoWithChannel(
    completion: @escaping (Result<VideosWithChannel, HttpError>) -> Void,
    _ isLive: Bool
  ) async {
    let url = isLive ?
      "\(baseUrl)/search?part=snippet&eventType=live&maxResults=10&regionCode=BR&relevanceLanguage=pt&type=video&key=\(apiKey)"
      :
      "\(baseUrl)/search?part=snippet&relevanceLanguage=pt&maxResults=10&videoDuration=medium&type=video&regionCode=BR&key=\(apiKey)"
    let responseVideo = await AF
      .request(
        url
      )
      .cacheResponse(using: .cache).serializingDecodable(Video.self).response

    switch responseVideo.result {
    case let .success(video):

      await video.items.asyncForEach { videoItem in
        AF
          .request(
            "\(baseUrl)/channels?part=statistics&part=snippet&id=\(videoItem.snippet.channelId)&key=\(apiKey)"
          )
          .cacheResponse(using: .cache).responseDecodable(of: Channel.self) { response in

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

  func fetchSubscription(token: String, completion: @escaping (Result<Subscription, HttpError>) -> Void) {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    AF
      .request(
        "\(baseUrl)/subscriptions?part=snippet&maxResults=10&mine=true&key=\(apiKey)",
        headers: headers
      )
      .cacheResponse(using: .cache).responseDecodable(of: Subscription.self) { data in

        switch data.result {
        case let .failure(error):
          debugPrint(error)
          completion(.failure(.noData))

        case let .success(subscription):
          completion(.success(subscription))
        }
      }
  }

  func fetchDetailsSingleChannel(
    witchChannelId channelId: String,
    completion: @escaping (Result<Channel, HttpError>) -> Void
  ) {
    AF
      .request(
        "\(baseUrl)/channels?part=statistics&part=snippet&id=\(channelId)&key=\(apiKey)"
      )
      .cacheResponse(using: .cache).responseDecodable(of: Channel.self) { response in

        switch response.result {
        case let .success(channel):

          completion(.success(channel))
        case let .failure(error):
          debugPrint(error)
          completion(.failure(.badResponse))
        }
      }
  }

  func fetchDetailsVideo(completion: @escaping (Result<VideoDetails, HttpError>) -> Void, videoId: String) {
    AF
      .request(
        "\(baseUrl)/videos?part=snippet&part=statistics&id=\(videoId)&key=\(apiKey)"
      )
      .cacheResponse(using: .cache).responseDecodable(of: VideoDetails.self) { data in

        switch data.result {
        case let .failure(error):
          debugPrint(error)
          completion(.failure(.noData))

        case let .success(video):
          completion(.success(video))
        }
      }
  }

  func fetchPlayListChannel(
    withChannelId channelId: String,
    completion: @escaping (Result<PlaylistItemsVideosChannel, HttpError>) -> Void
  ) async {
    let responseIdsPlaylist = await AF
      .request(
        "\(baseUrl)/playlists?part=id&maxResults=10&channelId=\(channelId)&key=\(apiKey)"
      )
      .cacheResponse(using: .cache).serializingDecodable(PlaylistIdsVideosChannel.self).response

    switch responseIdsPlaylist.result {
    case let .success(playListIdsVideos):

      await playListIdsVideos.items.asyncForEach { idsPlayList in

        AF
          .request(
            "\(baseUrl)/playlistItems?part=snippet&maxResults=1&playlistId=\(idsPlayList.id)&key=\(apiKey)"
          )
          .cacheResponse(using: .cache).responseDecodable(of: PlaylistItemsVideosChannel.self) { response in

            switch response.result {
            case let .success(playLists):

              completion(.success(playLists))
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
