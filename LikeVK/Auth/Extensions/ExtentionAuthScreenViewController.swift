
import Foundation
import UIKit
import VK_ios_sdk

extension AuthScreenViewController : VKDelegate {
    
    func getPersonalInfo() {
        VKManager.shared.getPersonalInfo()
    }
    
    func getFriendsInfo() {
        VKManager.shared.getFriends()
    }
    
    // Переход на экран личного профайла
    func goToProfile() {
//        if let top = AppDelegate.top {
//            let progressHUD = ProgressIndicator(text: "Загрузка данных")
//            top.view.addSubview(progressHUD)
            //let storyboard = UIStoryboard(name: "Profile", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as UIViewController
//            vc.modalPresentationStyle = UIModalPresentationStyle.currentContext
//            vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
//            top.present(vc, animated: true, completion: {})
//        }
        
        if AppDelegate.top?.view.viewWithTag(1) == nil {
            DispatchQueue.main.async {
                if let top = AppDelegate.top {
                    top.view.addSubview(self.progressHUD)
                }
            }
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
