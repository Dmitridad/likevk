
import Foundation
import UIKit

// Hardcode class
class User: NSObject {
    var profilePhoto = UIImage(named: "no-photo")!
    var name: String = ""
    var surname: String = ""
    var summary: String?
    var isOnline: Bool?
    var gender: Gender?
    var city: String?
    var degree: String?
    var workplace: String?
    var feeds: [FeedItem]?
    
    override init() {
        
    }

    init(profilePhoto: UIImage, name: String, surname: String, gender: Gender) {
        self.profilePhoto = profilePhoto
        self.name = name
        self.surname = surname
        self.gender = gender
    }
    
    init(name: String, surname: String, summary: String, city: String, degree: String, workplace: String, gender: Gender) {
        self.name = name
        self.surname = surname
        self.summary = summary
        self.city = city
        self.degree = degree
        self.workplace = workplace
        self.gender = gender
    }
}
