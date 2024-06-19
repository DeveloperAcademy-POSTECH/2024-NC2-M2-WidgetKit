
import SwiftUI

struct HeaderView: View {
    var body: some View {
        // 오늘의 운세 설명 부분
        ZStack {
            Rectangle()
                .fill(.palePink)
                .frame(height: 180)
            VStack {
                Text("오늘의 운세")
                    .font(.title)
                    .bold()
                    .padding(5)
                Text("뭐 오늘도 좋은 하루겠지")
            }
        }
    }
}

#Preview {
    HeaderView()
}
