
import ActivityKit
import WidgetKit
import SwiftUI
import AppIntents

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), imageName: getSelectedImage(), selectedImage_Kor: getSelectedImage_Kor(), geminiFortune: getGeminiFortune(), isShowingFortune: isShowingFortune())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, imageName: getSelectedImage(), selectedImage_Kor: getSelectedImage_Kor(), geminiFortune: getGeminiFortune(), isShowingFortune: isShowingFortune())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, imageName: getSelectedImage(), selectedImage_Kor: getSelectedImage_Kor(), geminiFortune: getGeminiFortune(), isShowingFortune: isShowingFortune())
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    private func getSelectedImage() -> String {
        let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune")
        return defaults?.string(forKey: "selectedImage") ?? "placeholder"
    }
    
    private func getSelectedImage_Kor() -> String {
        let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune")
        return defaults?.string(forKey: "selectedImage_Kor") ?? "placeholder"
    }
    
    
    private func getGeminiFortune() -> String {
        let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune")
        return defaults?.string(forKey: "geminiFortune") ?? "placeholder"
    }
    
    private func isShowingFortune() -> Bool {
        let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune")
        return defaults?.bool(forKey: "isShowingFortune") ?? true
    }
    
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let imageName: String
    let selectedImage_Kor: String
    let geminiFortune: String
    let isShowingFortune: Bool
}

struct TodayFortuneEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    
    var body: some View {
        
        switch widgetFamily {
        case .systemSmall:
            ZStack {
                ContainerRelativeShape()
                    .fill(.white)
                
                Button(intent: ToggleFortuneIntent()){
                    VStack {
                        if !entry.isShowingFortune {
                            if entry.imageName == "mouse" {
                                ZStack {
                                    Image("mouse_widget")
                                    
                                    Image("3D_Mouse")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                                
                            } else if entry.imageName == "rabbit" {
                                ZStack {
                                    Image("rabbit_widget")
                                    
                                    
                                    Image("3D_Rabbit")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                            }
                            else {
                                Image(entry.imageName)
                                    .resizable()
                                    .scaledToFit()
                            }
                        } else {
                            ZStack {
                                Image("rabbit_widget")

                                Text(entry.geminiFortune)
                                    .fontWeight(.thin)
                                    .font(.footnote)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                                
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            
        case .systemMedium:
            ZStack {
                ContainerRelativeShape()
                    .fill(.white)
                
                Button(intent: ToggleFortuneIntent()){
                    VStack {
                        if !entry.isShowingFortune {
                            if entry.imageName == "mouse" {
                                ZStack {
                                    Image("mouse_long_widget")
                                    
                                    Image("3D_Mouse")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                                
                            } else if entry.imageName == "rabbit" {
                                ZStack {
                                    Image("rabbit_long_widget")
                                    
                                    Image("3D_Rabbit")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                                
                            }
                            else {
                                Image(entry.imageName)
                                    .resizable()
                                    .scaledToFit()
                                
                            }
                        } else {
                            ZStack {
                                Image("rabbit_long_widget")

                                Text(entry.geminiFortune)
                                    .fontWeight(.thin)
                                    .font(.title3)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                            }
                            
                        }
                    }
                    
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            
        default:
            ZStack {
                ContainerRelativeShape()
                    .fill(.white)
                
                Button(intent: ToggleFortuneIntent()){
                    VStack {
                        if !entry.isShowingFortune {
                            if entry.imageName == "mouse" {
                                ZStack {
                                    Image("mouse_widget")
                                        .resizable()
                                    
                                    Image("3D_Mouse")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                                
                            } else if entry.imageName == "rabbit" {
                                ZStack {
                                    Image("rabbit_widget")
                                        .resizable()
//                                        .scaledToFit()
                                    
                                    Image("3D_Rabbit")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                            }
                            else {
                                Image(entry.imageName)
                                    .resizable()
                                    .scaledToFit()
                            }
                        } else {
                            
                            ZStack {
                                Image("rabbit_widget")
                                    .resizable()

                                Text(entry.geminiFortune)
                                    .fontWeight(.thin)
                                    .font(.title2)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                            }
                            
                        }
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
    }
}


struct TodayFortune: Widget {
    let kind: String = "TodayFortune"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TodayFortuneEntryView(entry: entry)
        }
        .contentMarginsDisabled()
    }
}


struct ToggleFortuneIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Fortune Display"
    
    func perform() async throws -> some IntentResult {
        let defaults = UserDefaults(suiteName: "group.com.soy.TodayFortune")
        let isShowingFortune = defaults?.bool(forKey: "isShowingFortune") ?? true
        defaults?.set(!isShowingFortune, forKey: "isShowingFortune")
        WidgetCenter.shared.reloadTimelines(ofKind: "TodayFortune")
        
        return .result()
    }
}

