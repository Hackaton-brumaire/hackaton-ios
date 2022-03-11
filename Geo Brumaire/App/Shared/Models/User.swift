import Combine

final class User: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var sessionId: String?
    
    init() {}
}
