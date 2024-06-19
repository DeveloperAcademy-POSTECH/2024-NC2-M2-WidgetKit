//
//  TodayFortuneLiveActivity.swift
//  TodayFortune
//
//  Created by 이소현 on 6/17/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TodayFortuneAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties ab out your activity go here!
    var name: String
}

struct TodayFortuneLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TodayFortuneAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TodayFortuneAttributes {
    fileprivate static var preview: TodayFortuneAttributes {
        TodayFortuneAttributes(name: "World")
    }
}

extension TodayFortuneAttributes.ContentState {
    fileprivate static var smiley: TodayFortuneAttributes.ContentState {
        TodayFortuneAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TodayFortuneAttributes.ContentState {
         TodayFortuneAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TodayFortuneAttributes.preview) {
   TodayFortuneLiveActivity()
} contentStates: {
    TodayFortuneAttributes.ContentState.smiley
    TodayFortuneAttributes.ContentState.starEyes
}
