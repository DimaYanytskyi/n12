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
        HStack(spacing: 4) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 4) {
                        Image(tabs[index].icon)
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        Text(tabs[index].title)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(selectedTab == index ? Color(red: 64, green: 181, blue: 1) : Color.clear)
                .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color(red: 35, green: 58, blue: 69, opacit: 1))
    }
}

#Preview {
    TabBar(selectedTab: .constant(0))
}
