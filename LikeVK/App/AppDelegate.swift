import UIKit
import CoreData
//import Firebase
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String {
            VKSdk.processOpen(url, fromApplication: sourceApplication)
        }
        guard let urlScheme = url.scheme else {return false}
        
        return true
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    static var top: UIViewController? {
         get {
             if let scene = UIApplication.shared.connectedScenes.first,
                let sceneDelegate  = scene as? UIWindowScene,
                let rootVC = sceneDelegate.windows.first?.rootViewController {
                
                 return rootVC
             }
            
             return nil
         }
     }
}

