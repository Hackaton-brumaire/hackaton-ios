import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var user: User?
    @Published var username: String = ""
    @Published var password: String = ""
    
    func login() async {
        user?.isAuthenticated.toggle()
    }
}
