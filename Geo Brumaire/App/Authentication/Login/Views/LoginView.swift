import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    @EnvironmentObject var user: User
    
    var body: some View {
        List {
            HStack {
                Text("Username")
                TextField("Enter your username", text: $viewModel.username)
                    .textContentType(.username)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Password")
                SecureField("Enter your password", text: $viewModel.password)
                    .multilineTextAlignment(.trailing)
            }
        }
        .navigationTitle("Login")
        .toolbar {
            switch viewModel.state {
            case .loading:
                ProgressView()
            default:
                Button {
                    Task {
                        await viewModel.login()
                    }
                } label: {
                    Text("Login")
                }
                .disabled(!viewModel.isLoginButtonClickable)
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
