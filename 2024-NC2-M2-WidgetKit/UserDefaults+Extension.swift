
import Foundation


extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.soy.TodayFortune"
        return UserDefaults(suiteName: appGroupId)!
    }
}
