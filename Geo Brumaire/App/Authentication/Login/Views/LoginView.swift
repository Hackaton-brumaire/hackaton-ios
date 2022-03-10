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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await viewModel.login()
                    }
                } label: {
                    Text("Login")
                }

            }
        }
        .onAppear {
            viewModel.user = user
        }
    }
}
