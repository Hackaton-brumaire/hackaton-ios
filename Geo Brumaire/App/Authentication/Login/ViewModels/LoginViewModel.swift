import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var state: LoadingState = .success
    @Published var user: User?
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isErrorAlertPresented: Bool = false
    
    var isLoginButtonClickable: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    @MainActor func login() async {
        state = .loading
        do {
            let request = try LoginRequest(username: username, password: password)
            let sessionId = try await request.perform()
            state = .success
            user?.sessionId = sessionId
            user?.isAuthenticated = true
        } catch {
            state = .failure(error)
            isErrorAlertPresented = true
        }
    }
}
