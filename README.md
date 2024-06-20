# 2024-NC2-M2-WidgetKit
Apple Developer Academy 3rd Morning Session NC2 Pair2(Soy&amp;Sora - SOSO)'s WidgetKit

## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About WidgetKit

> WwDC23부터 WidgetKit은 Interactivity를 지원, 사용자가 앱을 실행하지 않고도 위젯 내에서 직접 작업이 가능하도록 지원한다. </br> 'Button', 'Link', 'AppIntent' 컴포넌트를 활용하여 항목을 완료로 표시하거나 설정을 전환하는 등의 작업이 가능하다. </br> Interactive Widget은 사용자의 행동에 따라 콘텐츠를 새로 고칠 수 있어 Apple 기기에서 더 풍부하고 몰입감 있는 경험을 제공한다.

## 🎯 What we focus on?
> WidgetKit에서 iOS17부터 제공하는 interactivity를 활용해 앱을 실행하지 않고도 앱의 기능을 사용할 수 있도록 한다.

## 💼 Use Case
> 매일 확인하는 운세를 HomeScreen에서 바로 볼 수 있도록 하며, 부차적으로 아이폰을 꾸미는 데 도움을 준다.


## 🖼️ Prototype

- 위젯 이미지 (WidgetFamily: .systemSmall, .systemLarge / .systemMedium) : 위젯을 설치했을 때 기본적으로 나타나는 화면
</br>
<img src = "https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M2-WidgetKit/assets/127467306/f737efc0-a842-444b-bc95-de3ba8507d08" width = "200" height = "200"> | <img src = "https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M2-WidgetKit/assets/127467306/8f416b35-6795-45b1-a1d0-7a6c9d2f1a2e" width = "200" height = "100">

</br>
</br>

- HeaderView : 오늘의 운세가 나타나는 View

</br>
</br>
<img src = "https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M2-WidgetKit/assets/127467306/af7e6c6d-2518-44ac-8a98-554690500c4b" >
</br>


- MainView : 어플에서 처음으로 나타나는 View
</br>
</br>
<img src = "https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M2-WidgetKit/assets/127467306/10f7f0ee-139d-42c5-ac5e-f9648c9c46f4" width = "300" height = "600">
</br>


- Widget이 적용된 HomeScreen
</br>
</br>
<img src = "https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M2-WidgetKit/assets/127467306/e82979e3-4a59-4b99-9615-7a2b6afde110" width = "300" height = "600">



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
```
Interactivity를 추가하기 위해선 AppIntent가 필요함. 
AppIntent는 iOS가 필요할 때, 예를 들어 사용자가 위젯 버튼과 상호작용할 때 App 작업을 시스템에 노출하는 역할을 수행.
해당 코드에서는 UserDefaults에 저장된 "isShowingFortune" 값을 불러오도록 하고, "isShowingFortune"의 값에 따라 Widget에서 오늘의 운세 또는 띠에 해당하는 이미지를 보이도록 함 



## 👩‍💻 Contributor
<img width="174" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M2-WidgetKit/assets/127467306/60ec9f50-f43a-434b-9c54-bf765cb546b3"> | <img src = "https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M2-WidgetKit/assets/127467306/0b9a7b59-8e59-41ad-8540-4e4849f36db5" width = "200" height = "200">
--|--|
Soy|Sora
