import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        List {
            Section("Contact information") {
                HStack {
                    Text("Email")
                    TextField("Enter your email", text: $viewModel.email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Username")
                    TextField("Enter your username", text: $viewModel.username)
                        .textContentType(.username)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section("Password") {
                HStack {
                    Text("Password")
                    SecureField("Enter your password", text: $viewModel.password)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Confirm password")
                    SecureField("Re-enter your password", text: $viewModel.passwordConfirmation)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .navigationTitle("Register")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await viewModel.register()
                    }
                } label: {
                    Text("Register")
                }

            }
        }
    }
}
