import SwiftUI

final class RegisterViewModel: ObservableObject {
    @Published var state: LoadingState = .success
    @Published var user: User?
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var isErrorAlertPresented: Bool = false
    
    var isRegisterButtonClickable: Bool {
        !username.isEmpty && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty
    }
    
    @MainActor func register() async {
        guard password == passwordConfirmation else {
            isErrorAlertPresented = true
            return
        }
        
        state = .loading
        do {
            let request = try RegisterRequest(username: username, mail: email, password: password)
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
