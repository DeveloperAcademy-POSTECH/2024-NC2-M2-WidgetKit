
import Foundation
import SwiftUI
import Combine
import GoogleGenerativeAI

struct APIKey {
    static var value: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GeminiAPIKey") as? String else {
            fatalError("API Key not found")
        }
        return apiKey
    }
}


class APIModel: ObservableObject {
    @Published var storyText: String = "Loading..."
    
    private let model: GenerativeModel
    
    init() {
        self.model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.value)
    }
    
    func fetchGemini(prompt: String) {
        Task {
            do {
                let response = try await model.generateContent(prompt)
                if let text = response.text {
                    DispatchQueue.main.async {
                        self.storyText = text
                    }
                } else {
                    DispatchQueue.main.async {
                        self.storyText = "Failed to load Gemini."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.storyText = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}


let mousePrompt = "쥐띠의 오늘의 운세를 한 줄로 알려줘"


struct HeaderView: View {
    @StateObject private var apiModel = APIModel()
    @AppStorage("geminiFortune") var geminiFortune: String = ""
    
    var body: some View {
        // 오늘의 운세 설명 부분
        Button(action: {
            apiModel.fetchGemini(prompt: mousePrompt)
            self.geminiFortune = apiModel.storyText
        }, label: {
            ZStack {
                Rectangle()
                    .fill(.palePink)
                    .frame(height: 180)
                VStack {
                    Text("오늘의 운세")
                        .font(.title)
                        .bold()
                        .padding(5)
                    Text(apiModel.storyText)
                        .padding([.leading, .trailing])
                }
            }
        })
        .foregroundStyle(.black)
        .onAppear {
            apiModel.fetchGemini(prompt: mousePrompt)
        }
        
    }
}



#Preview {
    HeaderView()
}
