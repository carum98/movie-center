import Foundation
struct Genre : Identifiable, Codable {
    var id: Int
    var name : String
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
