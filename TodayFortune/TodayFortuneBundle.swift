//
//  TodayFortuneBundle.swift
//  TodayFortune
//
//  Created by 이소현 on 6/17/24.
//

import WidgetKit
import SwiftUI

@main
struct TodayFortuneBundle: WidgetBundle {
    var body: some Widget {
        TodayFortune()
        TodayFortuneLiveActivity()
    }
}
