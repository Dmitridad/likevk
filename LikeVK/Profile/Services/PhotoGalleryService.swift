import Foundation
import UIKit

class PhotoGalleryService {
    
    var images = [UIImage]()
    
    static var commonGallery: PhotoGalleryService = {
        let instance = PhotoGalleryService()
        return instance
    }()
    
    private init() {
        uploadGallery()
    }
    
    func uploadGallery() {
        let coffeeImage = UIImage(named: "coffee")!
        let microImage = UIImage(named: "microphone")!
        let snowImage = UIImage(named: "snow")!
        let womanImage = UIImage(named: "woman")!
        let catImage = UIImage(named: "cat")!
        let cityImage = UIImage(named: "city")!
        let escalatorImage = UIImage(named: "escalator")!
        let guitarImage = UIImage(named: "guitar")!
        let lightImage = UIImage(named: "light")!
        let metroImage = UIImage(named: "metro")!
        let carImage = UIImage(named: "car")!
        
        images.append(coffeeImage)
        images.append(microImage)
        images.append(snowImage)
        images.append(womanImage)
        images.append(catImage)
        images.append(cityImage)
        images.append(escalatorImage)
        images.append(guitarImage)
        images.append(lightImage)
        images.append(metroImage)
        images.append(carImage)
    }
}
