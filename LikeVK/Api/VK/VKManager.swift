
import Foundation
import VK_ios_sdk

class VKManager : NSObject, VKSdkUIDelegate, VKSdkDelegate {
    
    static let shared = VKManager()
    
    private var realm = RealmHelper()
    private let userDefaults = UserDefaultsHelper()
    
    private let vkId = "7718630"
    private let vkSecret = "ZY5AelF442SkBtMIoHMP"
    
    private let scope = ["offline", "friends", "photos", "status", "wall"]
    private var token = ""
    private var userId = 0
    weak var delegate: VKDelegate? = nil
    private var instance: VKSdk? = nil
    
    override init() {
        super.init()
        self.setup()
    }
    
    private func setup() {
        self.instance = VKSdk.initialize(withAppId: vkId)
        self.instance?.register(self)
        self.instance?.uiDelegate = self
        
        if ((self.userDefaults.getData("vk_user_id") as? Int) == nil) {
            VKSdk.forceLogout()
        }
    }
    
    /// Авторизация в VK
    func authorize() {
        VKSdk.wakeUpSession(scope) { [weak self] (state, error) in
            guard let self = self else { return }
            
            if state == .authorized {
                self.userId = self.userDefaults.getData("vk_user_id") as! Int
                self.token = self.userDefaults.getData("vk_access_token") as! String
                                
                self.delegate?.getPersonalInfo()
                self.delegate?.getFriendsInfo()
                self.delegate?.goToProfile()
            } else {
                if VKSdk.vkAppMayExists() {
                    VKSdk.authorize(self.scope, with: .disableSafariController)
                } else {
                    VKSdk.authorize(self.scope, with: .unlimitedToken)
                }
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let token = result.token, let userId = token.userId {
            self.userId = Int(userId) ?? 0
            self.token = token.accessToken
            
            userDefaults.saveData("vk_user_id", self.userId)
            userDefaults.saveData("vk_access_token", self.token)
            
            self.delegate?.getPersonalInfo()
            self.delegate?.getFriendsInfo()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        //
    }
    
    /// Получение личных данных из VK
    func getPersonalInfo() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let userRequest = VKApi.users()?.get([VK_API_USER_ID: "\(self.userId)", VK_API_FIELDS : "status, career, counters, education, city, photo_200"]) {
                userRequest.execute { (response: VKResponse<VKApiObject>?) in
                    if let  usersData = response?.parsedModel as? VKUsersArray {
                        if let user = (usersData.items as? [VKUser])?.first {
                            guard (user as VKUser) != nil else { return }
                            
                            self.realm.savePersonalInfo(user: user)
                        }
                    }
                    
                } errorBlock: { (error) in
                    print("ERROR:getPersonalInfo(): \(error?.localizedDescription as Any)")
                }
            }
        }
    }
    
    /// Получение данных друзей из VK
    func getFriends() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let userRequest = VKApi.friends()?.get([VK_API_USER_ID: "\(self.userId)", VK_API_FIELDS : "status, career, education, city, photo_200"]) {
                userRequest.execute { (response: VKResponse<VKApiObject>?) in
                    if let  friendsData = response?.parsedModel as? VKUsersArray {
                        if let friends = (friendsData.items as? [VKUser]) {
                            guard (friends as [VKUser]) != nil else { return }
                            
                            self.realm.saveFriends(vkFriends: friends)
                        }
                    }
                } errorBlock: { (error) in
                    print("ERROR:getFriends(): \(error?.localizedDescription as Any)")
                }
            }
        }
    }

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        if let top = AppDelegate.top {
            top.present(controller, animated: true, completion: {})
        }
    }
    
    func vkSdkWillDismiss(_ controller: UIViewController!) {
        if ((self.userDefaults.getData("vk_user_id") as? Int) != nil) {
            if let top = AppDelegate.top {
                let progressHUD = ProgressIndicator(text: "Загрузка данных")
                progressHUD.tag = 1
                
                DispatchQueue.main.async {
                    top.view.addSubview(progressHUD)
                }
                
            }
        }
    }
    
    func vkSdkDidDismiss(_ controller: UIViewController!) {
        if ((self.userDefaults.getData("vk_user_id") as? Int) != nil) {
            self.delegate?.goToProfile()
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        //
    }
}
