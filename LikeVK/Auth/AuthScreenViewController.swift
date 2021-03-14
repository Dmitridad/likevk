
import UIKit
import VK_ios_sdk

class AuthScreenViewController: UIViewController {
    
    let mainCornerRadius: CGFloat = 10
    let progressHUD = ProgressIndicator(text: "Загрузка данных")
    var userDefaults = UserDefaultsHelper()
    let popUpTip = PopUpTip(text: "Функционал в разработке")
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInWithAppleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.progressHUD.tag = 1
        self.logInButton.layer.cornerRadius = self.mainCornerRadius
        self.signInWithAppleButton.layer.cornerRadius = self.mainCornerRadius
        
        if ((self.userDefaults.getData("vk_user_id") as? Int) != nil) {
            self.autorizeVK()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        DispatchQueue.main.async {
            if let subview = AppDelegate.top?.view.viewWithTag(1) {
                subview.removeFromSuperview()
            }
        }
    }
    
    @IBAction func logInButtonClicked(_ sender: Any) {
        self.autorizeVK()
    }
    @IBAction func signInAppleButton(_ sender: UIButton) {
        let seconds = 1.0
        
        DispatchQueue.main.async {
            self.popUpTip.show()
            self.view.addSubview(self.popUpTip)
            self.popUpTip.backgroundColor = UIColor.black
        }
                
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.popUpTip.hide()
        }
    }
    
    private func autorizeVK() {
        VKManager.shared.delegate = self
        VKManager.shared.authorize()
    }
}
