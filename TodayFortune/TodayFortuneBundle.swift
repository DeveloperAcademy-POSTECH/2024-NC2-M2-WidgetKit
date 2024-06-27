

import WidgetKit
import SwiftUI

@main
struct TodayFortuneBundle: WidgetBundle {
    var body: some Widget {
        TodayFortune()
        TodayFortuneLiveActivity()
    }
}
