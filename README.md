# 2024-NC2-M2-WidgetKit
Apple Developer Academy 3rd Morning Session NC2 Pair2(Soy&amp;Sora - SOSO)'s WidgetKit

## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About WidgetKit

> WwDC23부터 WidgetKit은 Interactivity를 지원, 사용자가 앱을 실행하지 않고도 위젯 내에서 직접 작업이 가능하도록 지원한다는 것을 알게 됨 </br> 'Button', 'Link', 'AppIntent' 컴포넌트를 활용하여 항목을 완료로 표시하거나 설정을 전환하는 등의 작업이 가능함 </br> Interactivitive Widget은 사용자의 행동에 따라 콘텐츠를 새로 고칠 수 있어 Apple 기기에서 더 풍부하고 몰입감 있는 경험을 제공한다는 것을 배울 수 있었음

## 🎯 What we focus on?
> WidgetKit에서 iOS17부터 제공하는 interactivity를 활용해 앱을 실행하지 않고도 앱의 기능을 사용할 수 있도록 한다.

## 💼 Use Case
> 매일 확인하는 운세를 HomeScreen에서 바로 볼 수 있도록 하며, 부차적으로 아이폰을 꾸미는 데 도움을 준다.


## 🖼️ Prototype
(프로토타입과 설명 추가)

## 🛠️ About Code
```
struct ToggleFortuneIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Fortune Display"
    
    func perform() async throws -> some IntentResult {
        let defaults = UserDefaults(suiteName: "group.com")
        let isShowingFortune = defaults?.bool(forKey: "isShowingFortune") ?? true
        defaults?.set(!isShowingFortune, forKey: "isShowingFortune")
        WidgetCenter.shared.reloadTimelines(ofKind: "TodayFortune")
        
        return .result()
    }
}
```
```
Button(intent: ToggleFortuneIntent()){
  if !entry.isShowingFortune { ... } else { ... }
}
}
```
Interactivity를 추가하기 위해선 AppIntent가 필요함. 
AppIntent는 iOS가 필요할 때, 예를 들어 사용자가 위젯 버튼과 상호작용할 때 App 작업을 시스템에 노출하는 역할을 수행.
해당 코드에서는 UserDefaults에 저장된 "isShowingFortune" 값을 불러오도록 하고, "isShowingFortune"의 값에 따라 Widget에서 오늘의 운세 또는 띠에 해당하는 이미지를 보이도록 함 
