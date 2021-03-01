
import Foundation

protocol Person {
    var id: Int { get }
    var name: String { get }
    var surname: String { get }
    var summary: String { get }
    var city: String { get }
    var degree: String { get }
    var workplace: String { get }
    var followers: Int { get }
    var photo: String { get }
}
