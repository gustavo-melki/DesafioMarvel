import Foundation
import Moya
import RxSwift

public class MarvelManager {
  
  static let provider = MoyaProvider<MarvelService>()
  
  public static func getCharactersList() -> Observable<CharactersDataWrapper>{
    return self.provider.rx.request(.characters)
      .asObservable()
      .filterSuccessfulStatusCodes()
      .map(CharactersDataWrapper.self)
  }
}
