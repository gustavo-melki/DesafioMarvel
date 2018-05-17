import Foundation

public struct CharactersDataWrapper: Codable {
  
  public let code: Int?
  public let status: String?
  public let copyright: String?
  public let attributionText: String?
  public let attributionHTML: String?
  public let etag: String?
  public let data: CharactersDataContainer?
  
  enum CodingKeys: String, CodingKey {
    case code
    case status
    case copyright
    case attributionText
    case attributionHTML
    case etag
    case data
  }
}
