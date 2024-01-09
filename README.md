# Streaming Amazing
Aplicativo de streaming de vídeos, consumindo API do Youtube.  Pode visualizar na home os principais vídeos em alta e os canais em que a pessoa está inscrita. Possui tela para os vídeos ao vivo por fim visualizar o perfil do usuário.



## Feature
- Para usar repositório, precisa criar um arquivo de configuração e colocar o CLIENT_ID, caso não saiba fazer [consulte](https://docs.appcircle.io/environment-variables/using-environment-variables-in-ios-projects/#:~:text=We%20strongly%20recommend%20using%20environment,may%20increase%20your%20development%20time.)
- Também precisa de uma variável de ambiente, a qual você precisa setar e a API_KEY, caso não saiba fazer [consulte](https://www.swiftdevjournal.com/using-environment-variables-in-swift-apps/)
- Arquitetura que usei foi a MV, abaixo um exemplo que altera para MVVM

 ```swift


// MV nao possui views models

// Voce construi a camda HTTP Client e as camadas model


  |
  |
  |-> Models
        |
        | -> Channel
                |
                | -> Chanel -> aqui fica so camada da model
                  -> ChanelModel -> aqui fica a logica para consumir o http client e fornecer a model


//arquivo Channel
struct Channel: Codable {
  let items: [Items]
}

struct Items: Codable {
  let id: String
  let snippet: Snippet
  let statistics: StatisticsChannel
}

struct Snippet: Codable {
  let title: String
  let description: String
  let customUrl: String
  let publishedAt: String
  let thumbnails: ThumbnailsVideo
}

struct StatisticsChannel: Codable {
  let subscriberCount: String
}

//arquivo ChannelModel
class ChannelModel: ObservableObject {
  @Published var loading: LoadingState = .loading
  var channel: Channel = .init(items: [])
  private var httpClient = HttpClient()

  func fetchDetailsChannel(channelId: String) {
    httpClient.fetchDetailsSingleChannel(witchChannelId: channelId) { result in

      switch result {
      case let .success(channel):
        DispatchQueue.main.async {
          self.loading = .success
          self.channel = channel
        }

      case .failure:

        DispatchQueue.main.async {
          self.loading = .failure
        }
      }
    }
  }
}

```

##

- Trabalhei com conceito de concorrência em requisições em SwiftUi para isto criei uma extensão da API [Sequence]( https://www.swiftbysundell.com/articles/async-and-concurrent-forEach-and-map/)
- [Referencia usando concorrência em Alamorife](https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#using-alamofire-with-swift-concurrency)
- [Referência usando task](https://www.swiftbysundell.com/articles/swift-concurrency-multiple-tasks-in-parallel/)
- Abaixo um exemplo como usar e criar ela


```swift
// SequenceExtension


extension Sequence {
  func asyncForEach(
    _ operation: (Element) async throws -> Void
  ) async rethrows {
    for element in self {
      try await operation(element)
    }
  }

  func asyncMap<T>(
    _ transform: (Element) async throws -> T
  ) async rethrows -> [T] {
    var values = [T]()

    for element in self {
      try await values.append(transform(element))
    }

    return values
  }
}


// HttpClient

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



```

##

- Dicas que auxiliam na construção de interface
- Muitas vezes possuímos dificuldades em esticar imagem sem aumentar o zoom.
- Para manter o usuário logado ou deslogado, uma boa opção é passar uma variável é usar ela com binding em outros lugares para manipular a mesma.
- Manipulo a variável isLoggedIn tanto no BottomNaivgation quanto no SigIn
- Precisava ter acesso aos dados do usuário, melhor lugar para acessar o enviromentObject e tela responsável pela sua navegação.
-  Root apenas redireciona, então ideal é no BottomNavigation
- Para trabalhar com listas: remover os paddings internos, manipular o background color, remover o bounce e outras funcionalidades.
- Para trabalhar com placeholder de imagens, o ideal é usar uma local.


```swift

  //usar o aspectRatio ira auxilar em aumentar imagem sem zom
   AsyncImage(
          url: URL(
            string: "https://images.unsplash.com/photo-1638389746768-fd3020d35add?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
          )
        ) { phase in

          if let image = phase.image {
            image
              .resizable()
              .aspectRatio(1, contentMode: .fill) 
          }
        }
      }  


 // manter usuario logado
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

//Bottom Navigation
struct BottomNavigation: View {
  @State var currentTag: TabsTag = .home
  @Binding var isLoggedIn: Bool
  @StateObject var userAuthenticationModel = UserAuthenticationModel()

  func handleCurrentTag(_ tag: TabsTag) {
    currentTag = tag
  }

  var body: some View {
    NavigationStack {
      switch currentTag {
      case .home:
        HomeScreen()
          .safeAreaInset(edge: .bottom) {
            BottomItemNavigation(handleCurrentTag: handleCurrentTag, currentTag: currentTag)
              .offset(y: -15)
          }

      case .live:
        LiveScreen()
          .safeAreaInset(edge: .bottom) {
            BottomItemNavigation(handleCurrentTag: handleCurrentTag, currentTag: currentTag)
              .offset(y: -15)
          }
      case .profile:
        ProfileScreen(isLoggedIn: $isLoggedIn)
          .safeAreaInset(edge: .bottom) {
            BottomItemNavigation(handleCurrentTag: handleCurrentTag, currentTag: currentTag)
              .offset(y: -15)
          }
      }
    }
    .environmentObject(userAuthenticationModel)
  }
}

// Listas

 //remover bounce
 init(channel: ItensSubscription) {
    self.channel = channel
    UIScrollView.appearance().bounces = false // para retirar o bounce
  }


 List(playListChannelModel.listPlaylist, id: \.resourceId.videoId) { item in
            RowVideoChannel(item: item)
              .listRowInsets(EdgeInsets()) //remover paddings internos 
              .listRowSeparator(.hidden) // remover os sepadareods
              .listRowBackground(ColorsApp.gray50.opacity(0.7))
              .onTapGesture {
                isPresented = true
                playListSelected = item
                // para trabalhar com assincrono posso usar a palavara reservada  task
                //	Task {
                //
                //		 videosDetailsModel.fetchVideosDetails(videoId: item.resourceId.videoId)
                //
                //	}
              }
          }
          .listStyle(.inset) // remover o comportamento padrao das lidas
          .scrollContentBackground(.hidden) // esconder o background da lista
          .scrollIndicators(.never)
        }


//exemplo de skeleton usando imagem
struct PlaceholderAvatar: View {
  var body: some View {
    // para dar efeito bacana faz dowloud de uma imagme cinza
    // parecido com a cor do skeleton
    Image("skeleton")
      .resizable()
      .frame(width: 60, height: 60)
      .aspectRatio(contentMode: .fit)
      .clipShape(Circle())
  }
}



```
