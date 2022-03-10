import Combine

final class User: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    init() {}
}
