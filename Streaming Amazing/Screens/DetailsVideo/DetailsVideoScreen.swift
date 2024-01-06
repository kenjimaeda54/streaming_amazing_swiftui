//
//  DetailsVideoScreen.swift
//  Streaming Amazing
//
//  Created by kenjimaeda on 04/01/24.
//

import SwiftUI
import YouTubePlayerKit

struct DetailsVideoScreen: View {
  var video: VideosWithChannel
  @StateObject var videosDetailsModel = VideoDetailsModel()

  var youTubePlayer: YouTubePlayer {
    return YouTubePlayer(
      source: .video(id: video.videoId),
      configuration: .init(autoPlay: true, showRelatedVideos: false)
    )
  }

  func log10(val: Double) -> Double {
    return log(val) / log(10.0)
  }

  func formatQuantityView(value: String) -> String {
    let symbol = ["", "m", "mi", "b", "t", "p", "e"]
    let tier = Int(log10(val: abs(Double(value) ?? 0.0))) / 3 | 0

    if tier == 0 {
      return value
    }

    let suffix = symbol[tier]
    let scale = pow(10, tier * 3)

    let scaled = (Double(value) ?? 0.0) / Double(truncating: scale as NSNumber)

    return "\(scaled.rounded(toPlaces: 1)) \(suffix)"
  }

  func formatInterval(duration: TimeInterval) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    formatter.locale = Locale(languageCode: .portuguese, languageRegion: .brazil)

    return formatter.localizedString(fromTimeInterval: duration).capitalized
  }

  func formatPublishedVideo(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
    let date = dateFormatter.date(from: date)!
    return formatInterval(duration: Date().timeIntervalSince(date))
  }

  var body: some View {
    VStack(alignment: .leading) {
      ZStack(alignment: .topLeading) {
        YouTubePlayerView(self.youTubePlayer) { state in

          switch state {
          case .idle:
            ProgressView()

          case .error:
            Text("Error")

          case .ready:
            EmptyView()
          }
        }
        .ignoresSafeArea(.all)
        .background(
          ColorsApp.black100
        )
        BackButton()
      }

      switch videosDetailsModel.loading {
      case .loading:
        Text("loading")

      case .failure:
        EmptyView()

      case .success:
        ScrollView {
          VStack(alignment: .leading) {
            Text(video.titleVideo)
              .lineLimit(2)
              .fontWithLineHeight(font: UIFont(name: FontsApp.latoBold, size: 20)!, lineHeight: 32)
              .foregroundStyle(.black100)
            HStack {
              Text(formatPublishedVideo(video.publishedVideo))
                .font(.custom(FontsApp.latoLight, size: 13))
                .foregroundStyle(.gray100)
              Text(formatQuantityView(value: videosDetailsModel.videoDetails.items[0].statistics.viewCount))
                .font(.custom(FontsApp.latoLight, size: 13))
                .foregroundStyle(.gray100)
              Text(videosDetailsModel.videoDetails.items[0].snippet.channelTitle)
                .font(.custom(FontsApp.latoLight, size: 13))
                .foregroundStyle(.gray100)
            }
            .padding(.bottom, 40)
            HStack(alignment: .center) {
              AsyncImage(url: URL(
                string: video.thumbProfileChannel
              )) { phase in
                if let photo = phase.image {
                  photo
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
              }
              Text(videosDetailsModel.videoDetails.items[0].snippet.channelTitle)
                .font(.custom(FontsApp.latoBold, size: 19))
                .foregroundStyle(.black100)
                .frame(height: 20, alignment: .bottom)
              Text(formatQuantityView(value: video.subscriberCountChannel))
                .font(.custom(FontsApp.latoLight, size: 13))
                .foregroundStyle(.gray100)
                .frame(height: 16, alignment: .bottom)
            }
            Text(videosDetailsModel.videoDetails.items[0].snippet.description)
              .fontWithLineHeight(font: UIFont(name: FontsApp.latoRegular, size: 17)!, lineHeight: 25)
              .foregroundStyle(.black100)
          }
        }
        .padding(.horizontal, 15)
        .contentMargins(.bottom, 50)
        .scrollIndicators(.never, axes: .vertical)
      }
    }
    .ignoresSafeArea(.all)
    .onAppear {
      videosDetailsModel.fetchVideosDetails(videoId: video.videoId)
    }
  }
}

#Preview {
  DetailsVideoScreen(video: videosWithChannelMock[0])
}
