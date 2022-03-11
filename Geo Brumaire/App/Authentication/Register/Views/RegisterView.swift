import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    @EnvironmentObject var user: User
    
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
                switch viewModel.state {
                case .loading:
                    ProgressView()
                default:
                    Button {
                        Task {
                            await viewModel.register()
                        }
                    } label: {
                        Text("Register")
                    }
                    .disabled(!viewModel.isRegisterButtonClickable)
                }
            }
        }
        .alert("Error", isPresented: $viewModel.isErrorAlertPresented, actions: {
            Button("Ok", role: .cancel) {
                viewModel.isErrorAlertPresented = false
            }
        }, message: {
            Text("An error occured. Please verify your information.")
        })
        .onAppear {
            viewModel.user = user
        }
    }
}
