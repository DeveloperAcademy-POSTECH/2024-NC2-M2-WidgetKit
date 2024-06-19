
import SwiftUI

@main
struct _024_NC2_M2_WidgetKitApp: App {
    var body: some Scene {
        WindowGroup {
            if let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune") {
                MainView()
                    .defaultAppStorage(defaults)
            } else {
                Text("Failed to load UserDefaults")
            }
        }
    }
}
