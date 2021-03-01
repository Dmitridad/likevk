
import Foundation
import RealmSwift

class PersonalInfo: Object, Person {
    @objc dynamic var id = 0
    @objc dynamic var name = "Name"
    @objc dynamic var surname = "Surname"
    @objc dynamic var summary = ""
    @objc dynamic var city = "Add"
    @objc dynamic var degree = "Add"
    @objc dynamic var workplace = "Add"
    @objc dynamic var followers = 0
    @objc dynamic var photo = ""

    
    override init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int, name: String, surname: String, summary: String, city: String, degree: String, workplace: String, followers: Int, photo: String) {
        if id != 0 { self.id = id }
        if name != "" { self.name = name }
        if surname != "" { self.surname = surname }
        if summary != "" { self.summary = summary }
        if city != "" { self.city = city }
        if degree != "" { self.degree = degree }
        if workplace != "" { self.workplace = workplace }
        if followers != 0 { self.followers = followers }
        if photo != "" { self.photo = photo }
    }
}
