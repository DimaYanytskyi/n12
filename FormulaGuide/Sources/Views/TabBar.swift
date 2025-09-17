import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int
    
    private let tabs = [
        (icon: "home", title: "Home"),
        (icon: "driving", title: "Tracks"),
        (icon: "people", title: "Teams"),
        (icon: "map", title: "Map"),
        (icon: "profile", title: "Profile")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 4) {
                        Image(tabs[index].icon)
                            .font(.title3)
                            .foregroundColor(selectedTab == index ? Color.init(red: 39, green: 246, blue: 140) : Color.white)
                        
                        Text(tabs[index].title)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(selectedTab == index ? Color.init(red: 39, green: 246, blue: 140) : Color.white)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 16)
        .background(Color.purple.opacity(0.8))
    }
}

#Preview {
    TabBar(selectedTab: .constant(0))
}
