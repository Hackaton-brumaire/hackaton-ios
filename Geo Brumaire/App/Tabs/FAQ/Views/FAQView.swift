import SwiftUI

struct FAQView: View {
    @StateObject var viewModel = FAQViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.questions) { question in
                VStack(alignment: .leading) {
                    Text("Q: \(question.question)")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("A: \(question.answer)")
                }
            }
        }
        .navigationTitle("FAQ")
    }
}
