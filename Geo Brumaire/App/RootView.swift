import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "location.fill")
                }
            
            FAQView()
                .tabItem {
                    Label("FAQ", systemImage: "questionmark")
                }
            
            UserProfileView()
                .tabItem {
                    Label("User Profile", systemImage: "person.fill")
                }
        }
    }
}
