import Foundation
import SwiftUI
import Combine
import GoogleGenerativeAI
//
//struct APIKey {
//    static var value: String {
//        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GeminiAPIKey") as? String else {
//            fatalError("API Key not found")
//        }
//        return apiKey
//    }
//}
//
//
//class APIModel: ObservableObject {
//    @Published var storyText: String = "Loading..."
//    
//    private let model: GenerativeModel
//    
//    init() {
//        self.model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.value)
//    }
//    
//    func fetchGemini(prompt: String) {
//        Task {
//            do {
//                let response = try await model.generateContent(prompt)
//                if let text = response.text {
//                    DispatchQueue.main.async {
//                        self.storyText = text
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        self.storyText = "Failed to load Gemini."
//                    }
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.storyText = "Error: \(error.localizedDescription)"
//                }
//            }
//        }
//    }
//}


let inputText = "다음 논문 초록을 최대 100자로 요약한 뒤 한글로 가독성 좋게 표현해줘.그리고 이 연구는~ 으로 시작하지 않게 해줘. Objectives: This study aims to identify the negative effects of cumulative traumatic events on both mental and physical health. Methods: Trauma was defined based on DSM-5 (Diagnostic and Statistical Manual of Mental Disorders Fifth Edition), SAMHSA (Substance Abuse and Mental Health Services Administration) recommendation, and previous studies. A cross-sectional study using an online survey questionnaire was used to gather sociodemographics, trauma, and health information. Data were analyzed with SAS version 9.4 software using Chi-Square tests and binary logistic regression analysis. Results: The results of the survey indicated that 89.9% of the people surveyed had experienced traumas during their lifetime and 66.3% during childhood. Respondents who experienced more than 7 traumas were 7.9 times more likely to have potential risk of PTSD (OR: 7.877; 95% CI: 5.314-11.677), 2.3 times more likely to have depression (OR: 2.333; 95% CI: 1.446-3.763), and 3.5 times more likely to have a complex chronic disease (OR: 3.522; 95% CI: 2.261-5.485). A similar trend was found among respondents who experienced trauma in childhood (potential risk of PTSD OR=7.627; depression OR=3.508; complex chronic disease OR=2.979). Conclusion: These findings suggest that cumulative trauma is associated with both negative mental and physical health. Individuals may be exposed to various types of traumas during their lifetime. Interventions are necessary to promote resilience so that cumulative trauma does not threaten an individual’s health and life."
let DBpiaURL = "https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE11139940"





struct APITestView: View {
    @StateObject private var apiModel = APIModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Magic Backpack Story:")
                .font(.headline)
                .padding(.top)
            Text(apiModel.storyText)
                .padding()
        }
        .padding()
        .task {
            await apiModel.fetchGemini(prompt: inputText)
        }
    }
}


