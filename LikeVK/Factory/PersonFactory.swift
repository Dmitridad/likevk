//
//  ModelsFactory.swift
//  likeVK
//
//  Created by Дмитрий Любецкий on 27.02.2021.
//

import Foundation
import RealmSwift

class PersonFactory: Person {
    var id: Int
    var name: String
    var surname: String
    var summary: String
    var city: String
    var degree: String
    var workplace: String
    var followers: Int
    var photo: String
    
    init(id: Int = 0,
         name: String = "",
         surname: String = "",
         summary: String = "",
         city: String = "",
         degree: String = "",
         workplace: String = "",
         followers: Int = 0,
         photo: String = "")
    {
        self.id = id
        self.name = name
        self.surname = surname
        self.summary = summary
        self.city = city
        self.degree = degree
        self.workplace = workplace
        self.followers = followers
        self.photo = photo
    }
    
    func createPerson(type: PersonEnum) -> Object {
        switch type {
        case .personalInfo:
            return PersonalInfo(id: self.id,
                                name: self.name,
                                surname: self.surname,
                                summary: self.summary,
                                city: self.city,
                                degree: self.degree,
                                workplace: self.workplace,
                                followers: self.followers,
                                photo: self.photo)
        case .friend:
            return Friend(id: self.id,
                          name: self.name,
                          surname: self.surname,
                          summary: self.summary,
                          city: self.city,
                          degree: self.degree,
                          workplace: self.workplace,
                          photo: self.photo)
        }
    }
}
