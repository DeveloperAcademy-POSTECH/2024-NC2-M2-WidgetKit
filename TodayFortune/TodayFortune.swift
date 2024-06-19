
import ActivityKit
import WidgetKit
import SwiftUI
import AppIntents

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), imageName: getSelectedImage(), geminiFortune: getGeminiFortune())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, imageName: getSelectedImage(), geminiFortune: getGeminiFortune())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            //            let imageName = UserDefaults(suiteName: "group.com.soy.TodayFortune")?.string(forKey: "selectedImage") ?? "placeholder"
            let entry = SimpleEntry(date: entryDate, configuration: configuration, imageName: getSelectedImage(), geminiFortune: getGeminiFortune())
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    private func getSelectedImage() -> String {
        let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune")
        return defaults?.string(forKey: "selectedImage") ?? "placeholder"
    }
    
    private func getGeminiFortune() -> String {
        let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune")
        return defaults?.string(forKey: "geminiFortune") ?? "placeholder"
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let imageName: String
    let geminiFortune: String
}

struct TodayFortuneEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Image(entry.imageName)
                .resizable()
                .scaledToFit()
            Text(entry.imageName)
                .font(.headline)
            Text(entry.geminiFortune)
                .fontWeight(.thin)
                .font(.footnote)
        }
        .padding()
    }
}


struct TodayFortune: Widget {
    let kind: String = "TodayFortune"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TodayFortuneEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}




//extension ConfigurationAppIntent {
//    fileprivate static var smiley: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "😀"
//        return intent
//    }
//
//    fileprivate static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
//        return intent
//    }
//}

//#Preview(as: .systemSmall) {
//    TodayFortune()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley, imageName: "mouse")
//    SimpleEntry(date: .now, configuration: .starEyes, imageName: "cow")
//}
