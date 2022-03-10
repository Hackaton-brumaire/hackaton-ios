import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("logo-brumaire")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Spacer()
                
                loginButton
                
                registerButton
                
                Spacer()
                
                copyrightLabel
            }
            .padding()
        }
    }
}

private extension WelcomeView {
    var loginButton: some View {
        NavigationLink {
            LoginView()
        } label: {
            HStack {
                Image(systemName: "envelope")
                
                Text("Login")
                    .fontWeight(.bold)
            }
        }
        .buttonStyle(LargeButtonStyle(foregroundColor: .white, backgroundColor: .blue))
    }
    
    var registerButton: some View {
        HStack(spacing: 4) {
            Text("Don't have an account yet?")
            
            NavigationLink {
                RegisterView()
            } label: {
                Text("Register!")
            }
        }
    }
    
    var copyrightLabel: some View {
        Text("Copyright © — Brumaire (en fait non)")
            .foregroundColor(Color(uiColor: UIColor.secondaryLabel))
    }
}
