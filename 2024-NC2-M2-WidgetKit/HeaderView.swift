
import Foundation
import SwiftUI
import Combine
import GoogleGenerativeAI
import WidgetKit

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
    
    func fetchGemini(prompt: String) async {
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




struct HeaderView: View {
    @StateObject private var apiModel = APIModel()
    @AppStorage("geminiFortune") var geminiFortune: String = ""
    @Binding var selectedImage: String
    
    var body: some View {
        let prompt = "\(selectedImage) 띠의 오늘의 운세를 한 줄로 알려줘. 좋은 운세 문장과 나쁜 운세 문장이 70:30의 비율로 랜덤하게 나타나도록 해줘. 그리고 이전 운세와 비슷한 문장은 최대한 피해줘. 무슨 띠의 운세인지가 문장의 주어가 되도록 해줘"
        
        // 오늘의 운세 설명 부분
        Button(action: {
            Task {
                await apiModel.fetchGemini(prompt: prompt)
                self.geminiFortune = apiModel.storyText
                WidgetCenter.shared.reloadAllTimelines()
            }
        }, label: {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                VStack {
                    Text("🍀오늘의 운세🍀")
                        .font(.title)
                        .bold()
                        .padding(5)
                    Text(apiModel.storyText)
                        .padding([.leading, .trailing])
                }
            }
        })
        .foregroundStyle(Color.colorForText)
        .task {
            await apiModel.fetchGemini(prompt: prompt)
        }
        .padding()
    }
}
