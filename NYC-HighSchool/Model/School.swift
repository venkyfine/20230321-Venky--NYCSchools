import Foundation

struct School: Decodable {
    // MARK: struct properties
    var name : String?
    // set CodingKeys if your properties name differ from api response key name
    enum CodingKeys: String, CodingKey {
       case name = "school_name"
    }
}
