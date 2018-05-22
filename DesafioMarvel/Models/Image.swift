import Foundation

public struct Image: Codable {
  
  public let path: String?
  public let _extension: String?
  
  enum CodingKeys: String, CodingKey {
    case path
    case _extension = "extension"
  }
}
