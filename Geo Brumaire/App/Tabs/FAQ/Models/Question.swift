import Foundation

struct Question: Identifiable {
    var id = UUID()
    var question: String
    var answer: String
}
