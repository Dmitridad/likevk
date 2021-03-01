
import Foundation
import RealmSwift
import VK_ios_sdk

struct RealmHelper {
    
    lazy var realm = try? Realm()
    
    /// Добавление данных любой модели
    mutating func addModels(_ model: Any) {
        try? realm?.write{
            realm?.add(model as! Object)
        }
    }
    
    /// Удаление данных одной модели или всех моделей
    mutating func deleteModels(_ model: Any, deleteAll: Bool = false) {
        if deleteAll == false {
            try? realm?.write{
                realm?.delete(model as! ObjectBase)
            }
        } else {
            try? realm?.write{
                realm?.deleteAll()
            }
        }
    }
    
    /// Сохранение личных данных из VK
    mutating func savePersonalInfo(user: VKUser) {
        
        // пример использования фабрики PersonFactory
        let person = PersonFactory(id: user.id.intValue ,name: user.first_name ?? "", surname: user.last_name ?? "", summary: user.status ?? "", city: user.city?.title ?? "", degree: user.university_name ?? "", workplace: user.career?.company ?? "", followers: user.counters.followers as! Int , photo: user.photo_200 ?? "")
        
//        if let personalInfo = realm?.objects(PersonalInfo.self) {
//            for personalInfoObj in personalInfo {
//                self.deleteModels(personalInfoObj)
//            }
//        }
        
        try? realm?.write{
            realm?.add(person.createPerson(type: .personalInfo) as! PersonalInfo, update: .modified)
        }
        
        print("Realm file path for PersonalInfo - \(Realm.Configuration.defaultConfiguration.fileURL as Any)")
    }
    
    /// Получение сохраненных личных данных из VK
    mutating func getPersonalInfo() -> PersonalInfo? {
        if let personalInfo = realm?.objects(PersonalInfo.self).first {
            return personalInfo
        }
        
        return nil
    }
    
    /// Сохранение данных друзей из VK
    mutating func saveFriends(vkFriends: [VKUser]) {
        
        var friendObjArr = [Friend]()
        
        for friend in vkFriends {
            
            let friendObj = Friend(id: friend.id.intValue ,name: friend.first_name ?? "", surname: friend.last_name ?? "", summary: friend.status ?? "", city: friend.city?.title ?? "", degree: friend.university_name ?? "", workplace: friend.career?.company ?? "", photo: friend.photo_200 ?? "")
            
            friendObjArr.append(friendObj)
        }
        
        if let friends = realm?.objects(Friend.self) {
            // Если кол-во друзей уменьшилось или увеличилось, удаляем всех друзей и создаем по новой
            if friends.count != friendObjArr.count {
                for friend in friends {
                    self.deleteModels(friend)
                }
                
                try? realm?.write{
                    for friend in friendObjArr {
                        realm?.add(friend)
                    }
                }
            // Если кол-во друзей осталось таким же, обновляем только измененные поля
            } else {
                try? realm?.write{
                    for friend in friendObjArr {
                        realm?.add(friend, update: .modified)
                    }
                }
            }
        }
        
        print("Realm file path for Friend - \(Realm.Configuration.defaultConfiguration.fileURL as Any)")
    }
    
    /// Получение сохраненных данных друзей из VK
    mutating func getFriends() -> [Friend]? {
        var friends = [Friend]()
        
        if let result = realm?.objects(Friend.self) {
            for friend in result {
                friends.append(friend)
            }
            
            return friends
        }
        
        return nil
    }
}
