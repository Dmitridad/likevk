
import UIKit
import VK_ios_sdk

class AuthScreenViewController: UIViewController {
    
    let mainCornerRadius: CGFloat = 10
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInWithAppleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.logInButton.layer.cornerRadius = self.mainCornerRadius
        self.signInWithAppleButton.layer.cornerRadius = self.mainCornerRadius
    }
    
    @IBAction func logInButtonClicked(_ sender: Any) {
        VKManager.shared.delegate = self
        VKManager.shared.authorize()
    }

}
