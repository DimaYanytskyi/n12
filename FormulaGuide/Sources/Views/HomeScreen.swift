import SwiftUI

struct HomeScreen: View {
    @Binding var selectedTab: Int
    @State private var currentHighlightPage = 1
    @State private var randomTracks: [Track] = []
    
    @EnvironmentObject var authManager: AuthMain
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, EEE"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Date())
    }
    
    private var userName: String {
        if let user = authManager.currentuser {
            return user.name
        } else {
            return "User"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(authManager.getSelectedAvatarName())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(userName)
                        .font(.custom("Inter24pt-ExtraBold", size: 18))
                        .foregroundColor(Color.white)
                    
                    Text(currentDate)
                        .font(.custom("Inter24pt-Regular", size: 15))
                        .foregroundColor(Color.white.opacity(0.5))
                }
                
                Spacer()
                
                NavigationLink(destination: NotificationsScreen()) {
                    Image(.notificationButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 10)
            .background(Color(red: 42, green: 59, blue: 76))
            .padding(.horizontal, -24)
            
            HStack(spacing: 13) {
                Button(action: {
                    selectedTab = 1
                }) {
                    Image(.tracksButton)
                        .resizable()
                        .scaledToFit()
                }
                
                Button(action: {
                    selectedTab = 2
                }) {
                    Image(.teamsButton)
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(.top, 24)
            
            Button(action: {
                selectedTab = 3
            }) {
                Image(.mapButton)
                    .resizable()
                    .scaledToFit()
            }
            .padding(.top, 13)
                        
            VStack(alignment: .leading, spacing: 16) {
                Text("Highlight")
                    .font(Font.custom("Inter24pt-ExtraBold", size: 24))
                    .foregroundColor(Color(red: 18, green: 18, blue: 31))
                
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(Array(randomTracks.enumerated()), id: \.element.id) { index, track in
                                NavigationLink(destination: TrackDetailScreen(track: track)) {
                                    Image(track.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 170)
                                }
                                .background(
                                    GeometryReader { itemGeometry in
                                        Color.clear
                                            .preference(key: ScrollOffsetPreferenceKey.self, value: [
                                                index: itemGeometry.frame(in: .named("scroll")).minX
                                            ])
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .coordinateSpace(name: "scroll")
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { values in
                        updateCurrentPage(geometry: geometry, values: values)
                    }
                }
                .frame(height: 170)
                .padding(.horizontal, -24)
                
                HStack(spacing: 4) {
                    Spacer()
                    ForEach(1 ... 3, id: \.self) { index in
                        if index == currentHighlightPage {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color(red: 116, green: 182, blue: 3))
                                .frame(width: 30, height: 5)
                        } else {
                            Circle()
                                .fill(Color(red: 116, green: 182, blue: 3))
                                .frame(width: 5, height: 5)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.top, 24)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
        .onAppear {
            generateRandomTracks()
        }
    }
    
    private func generateRandomTracks() {
        let allTracks = Track.sampleTracks
        var shuffledTracks = allTracks.shuffled()
        
        randomTracks = Array(shuffledTracks.prefix(3))
    }
    
    private func updateCurrentPage(geometry: GeometryProxy, values: [Int: CGFloat]) {
        let screenWidth = geometry.size.width
        let centerX = screenWidth / 2
        
        var closestIndex = 0
        var minDistance: CGFloat = .infinity
        
        for (index, offset) in values {
            let itemCenterX = offset + (screenWidth - 48) / 2
            let distance = abs(itemCenterX - centerX)
            
            if distance < minDistance {
                minDistance = distance
                closestIndex = index
            }
        }
        
        currentHighlightPage = closestIndex + 1
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue()) { _, new in new }
    }
}

#Preview {
    HomeScreen(selectedTab: .constant(0))
}
