import SwiftUI

struct TracksScreen: View {
    @State private var searchText = ""
    @State private var selectedCountry: String = ""
    @State private var selectedTrack: Track?
    
    private let tracks = Track.sampleTracks
    private let countries = Array(Set(Track.sampleTracks.map { $0.country })).sorted()
    
    var filteredTracks: [Track] {
        var filtered = tracks
        
        if !searchText.isEmpty {
            filtered = filtered.filter { track in
                track.name.localizedCaseInsensitiveContains(searchText) ||
                track.country.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if !selectedCountry.isEmpty {
            filtered = filtered.filter { $0.country == selectedCountry }
        }
        
        return filtered
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Tracks")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink(destination: NotificationsScreen()) {
                    Image(.notificationButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            .padding(.top, 24)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(filteredTracks) { track in
                        NavigationLink(destination: TrackDetailScreen(track: track)) {
                            TrackCard(track: track)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}

struct TrackCard: View {
    let track: Track
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                Image(track.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 170)
                    .clipped()
                
                Button(action: {
                    favoritesManager.toggleTrackFavorite(track.id)
                }) {
                    Image(.star)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(favoritesManager.isTrackFavorite(track.id) ? Color(red: 255/255, green: 92/255, blue: 0/255) : .white)
                        .frame(width: 24, height: 24)
                }
                .padding(12)
            }
        }
    }
}

#Preview {
    TracksScreen()
}
