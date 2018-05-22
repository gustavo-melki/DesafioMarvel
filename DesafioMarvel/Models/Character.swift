import Foundation

public struct Character: Codable {
  
  public let id: Int?
  public let name: String?
  public let description: String?
  public let thumbnail: Image?
  //public let comics: [Comic]?
  //public let series: [Serie]?

  
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case thumbnail
    //case comics
    //case series
  }
}

