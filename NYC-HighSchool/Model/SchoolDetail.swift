import Foundation

struct SchoolDetail: Decodable {
    // MARK: struct properties
    var name : String?
    var maths : String?
    var reading : String?
    var writing : String?
    // set CodingKeys if your properties name differ from api response key name
    enum CodingKeys: String, CodingKey {
        case name = "school_name"
        case maths = "sat_math_avg_score"
        case reading = "sat_critical_reading_avg_score"
        case writing = "sat_writing_avg_score"
    }
}
