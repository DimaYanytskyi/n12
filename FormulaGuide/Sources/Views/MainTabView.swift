
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var authManager: AuthMain
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeScreen(selectedTab: $selectedTab)
                }
                .tag(0)
                
                NavigationStack {
                    TracksScreen()
                }
                .tag(1)
                
                NavigationStack {
                    TeamsScreen()
                }
                .tag(2)
                
                NavigationStack {
                    MapScreen()
                }
                .tag(3)
                
                NavigationStack {
                    ProfileScreen()
                }
                .tag(4)
            }
            
            TabBar(selectedTab: $selectedTab)
        }
    }
}


#Preview {
    MainTabView()
        .environmentObject(AuthMain())
}
