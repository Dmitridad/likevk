import Foundation

struct UserDefaultsHelper {
    
    let userDefaults = UserDefaults.standard
    
    func saveData(_ key: String,_ value: Any) {
        self.deleteData(key: key)
        self.userDefaults.set(value, forKey: key)
    }
    
    func getData(_ key: String) -> Any {
        guard let data = self.userDefaults.object(forKey: key) else { return "" }
        
        return data
    }
    
    func deleteData(key: String) {
        self.userDefaults.removeObject(forKey: key)
    }
}
