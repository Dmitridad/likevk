import Foundation
import UIKit
import CoreData

class DataBaseService {
    
    var friendsRequests = [User]()
    var myself = User()

    static var commonService: DataBaseService = {
        let instance = DataBaseService()
        return instance
    }()
    
    private init() {
        addMyself()
        addFriendsRequests()
    }
    
    private func addMyself() {
        var feeds = [FeedItem]()
        let feedItem = FeedItem()
        
        feedItem.image = UIImage(named: "car")
        feedItem.publicationDate = Date()
        feedItem.text = "Feed text"
        feedItem.likeCount = 30
        
        feeds.append(feedItem)
        feeds.append(feedItem)
        
        myself.feeds = feeds
    }
    
    private func addFriendsRequests() {
        friendsRequests.append(
            User(name: "Bob", surname: "Marley", summary: "", city: "", degree: "", workplace: "",  gender: Gender.male))
        friendsRequests.append(
            User(name: "Tereza", surname: "Mom", summary: "", city: "", degree: "", workplace: "", gender: Gender.female))
        friendsRequests.append(
            User(name: "Kaco", surname: "Itochel", summary: "", city: "", degree: "", workplace: "", gender: Gender.male))
        friendsRequests.append(
            User(name: "Malen", surname: "Kyhren", summary: "", city: "", degree: "", workplace: "", gender: Gender.male))
    }
}
