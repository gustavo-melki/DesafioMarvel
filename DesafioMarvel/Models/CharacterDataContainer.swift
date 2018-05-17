import Foundation

public struct CharactersDataContainer: Codable {
  
  public let offset: Int?
  public let limit: Int?
  public let total: Int?
  public let count: Int?
  public let results: [Character]?
 
  
  enum CodingKeys: String, CodingKey {
    case offset
    case limit
    case total
    case count
    case results
  }
}
