import Foundation
import UIKit

extension UITextField {
    func setLeftOffset(to value: CGFloat) {
        let offset = CGRect(x: self.frame.minX, y: self.frame.minY, width: value, height: self.frame.height)
        self.leftView = UIView(frame: offset)
        self.leftViewMode = .always
    }
    
    func setLeftImage(image: UIImage, color: UIColor, size: CGFloat) {
        let offset: CGFloat = 5
        let view = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size + offset * 2, height: size + offset * 2))
        let imageView = UIImageView(frame: CGRect(x: offset, y: offset, width: size, height: size))
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = color
        view.contentMode = .center
        view.addSubview(imageView)
        
        self.leftView = view
        self.leftViewMode = .always
    }
}
