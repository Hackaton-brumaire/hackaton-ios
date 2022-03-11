import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Button {
            user.sessionId = nil
            user.isAuthenticated = false
        } label: {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                
                Text("Sign out")
                    .fontWeight(.bold)
            }
        }
        .buttonStyle(LargeButtonStyle(foregroundColor: .white, backgroundColor: .red))
        .padding()
        .navigationTitle("User Profile")
    }
}
