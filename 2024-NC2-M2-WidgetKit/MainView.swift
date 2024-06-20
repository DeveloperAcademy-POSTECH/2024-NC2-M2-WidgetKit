
import SwiftUI
import WidgetKit

struct MainView: View {
    @State private var showToast = false
    @State private var isAnimating = false
    @AppStorage("selectedImage") var selectedImage: String = ""
    @AppStorage("selectedImage_Kor") var selectedImage_Kor: String = ""
    
    // imageName의 2차원 배열
    var imageName = [
        ["mouse", "cow", "tiger"],
        ["rabbit", "dragon", "snake"],
        ["horse", "sheep", "monkey"],
        ["chicken", "dog", "pig"]
    ]
    
    var imageName_Kor = [
        ["쥐띠", "소띠", "호랑이띠"],
        ["토끼띠", "용띠", "뱀띠"],
        ["말띠", "양띠", "원숭이띠"],
        ["닭띠", "개띠", "돼지띠"]
    ]
    
    var body: some View {
        ScrollView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFit()
//                    .frame(width: 500)
//                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    
                
                VStack{
                    
                    HeaderView(selectedImage: $selectedImage)
                    
                    ZStack {
                        // 십이간지가 그려진 버튼
                        VStack {
                            ForEach(0 ..< 4) { height in
                                HStack {
                                    ForEach(0 ..< 3) { width in
                                        Button(action: {
                                            self.selectedImage = imageName[height][width]
                                            self.selectedImage_Kor = imageName_Kor[height][width]
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
                                                Text("\(imageName_Kor[height][width])")
                                            }
                                        })
                                        .foregroundStyle(Color.colorForText)
                                        .bold()
                                    }
                                }
                                
                            }
                        }
                        if showToast {
                            ToastView(message: "해당 띠가 적용되었습니다")
                                .transition(.slide)
                                .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        }
                    }
                    .scaledToFit()
                }
                
            }

        }
        .background(Color.palePink)
        .ignoresSafeArea()
    }
}







struct ToastView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.pink.opacity(0.8))
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
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
