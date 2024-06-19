
import SwiftUI
import WidgetKit

struct MainView: View {
    @State private var showToast = false
    @State private var isAnimating = false
    @AppStorage("selectedImage") var selectedImage: String = ""
    
    
    
    // imageName의 2차원 배열
    var imageName = [
        ["mouse", "cow", "tiger"],
        ["rabbit", "dragon", "snake"],
        ["horse", "sheep", "monkey"],
        ["chicken", "dog", "pig"]
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                
                HeaderView()
                
                ZStack {
                    // 십이간지가 그려진 버튼
                    VStack {
                        ForEach(0 ..< 4) { height in
                            HStack {
                                ForEach(0 ..< 3) { width in
                                    Button(action: {
                                        self.selectedImage = imageName[height][width]
                                        self.showToast = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.showToast = false
                                        }
                                        WidgetCenter.shared.reloadAllTimelines()
                                    }, label: {
                                        VStack {
                                            Image(imageName[height][width])
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                            Text("\(imageName[height][width])")
                                        }
                                    })
                                }
                            }
                            
                        }
                    }
                    if showToast {
                        ToastView(message: "This is a Toast message")
                            .transition(.slide)
                            .animation(.easeInOut(duration: 0.5), value: isAnimating)
                    }
                }
            }
        }
    }
}







struct ToastView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundStyle(Color.white)
            .clipShape(Rectangle())
            .padding(.horizontal, 20)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
    }
}

//extension UserDefaults {
//    static var shared: UserDefaults {
//        let appGroupId = "group.com.soy.TodayFortune"
//        return UserDefaults(suiteName: appGroupId)!
//    }
//}



#Preview {
    MainView()
}
