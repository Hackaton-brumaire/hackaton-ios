import SwiftUI

enum NavigationState: Hashable {
    case home
    case map
    case faq
    case userProfile
}

struct RootView: View {
    @StateObject var user = User()
    @State var navigationState: NavigationState = .home
    
    var body: some View {
        TabView(selection: $navigationState) {
            NavigationView {
                HomeView(navigationState: $navigationState)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(NavigationState.home)
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "location.fill")
                }
                .tag(NavigationState.map)
            
            NavigationView {
                FAQView()
            }
            .tabItem {
                Label("FAQ", systemImage: "questionmark")
            }
            .tag(NavigationState.faq)
            
            NavigationView {
                UserProfileView()
            }
            .tabItem {
                Label("User Profile", systemImage: "person.fill")
            }
            .tag(NavigationState.userProfile)
            .environmentObject(user)
        }
        .fullScreenCover(isPresented: $user.isAuthenticated.opposite) {
            WelcomeView()
                .environmentObject(user)
                .onAppear {
                    navigationState = .home
                }
        }
    }
}
