import SwiftUI
import MapKit

struct MapScreen: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 60.0, longitudeDelta: 60.0)
    )
    
    @State private var selectedTrack: Track?
    @State private var showingTrackDetail = false
    @State private var searchText = ""
    @State private var showingSearchResults = false
    @State private var routeOverlay: MKPolyline?
    @State private var selectedTracks: [Track] = []
    @State private var showingRouteOptions = false
    
    var filteredTracks: [Track] {
        if searchText.isEmpty {
            return Track.sampleTracks
        } else {
            return Track.sampleTracks.filter { track in
                track.name.localizedCaseInsensitiveContains(searchText) ||
                track.country.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Map")
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
            .padding(.horizontal, 24)
            
            if !selectedTracks.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(selectedTracks) { track in
                            HStack {
                                Image(track.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                
                                Text(track.name)
                                    .font(Font.custom("Inter24pt-Medium", size: 12))
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    selectedTracks.removeAll { $0.id == track.id }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 12))
                                }
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.top, 8)
            }
            
            if !searchText.isEmpty && !filteredTracks.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(filteredTracks) { track in
                            Button(action: {
                                centerMapOnTrack(track)
                                searchText = ""
                            }) {
                                HStack {
                                    Image(track.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(track.name)
                                            .font(Font.custom("Inter24pt-Medium", size: 14))
                                            .foregroundColor(.white)
                                        
                                        Text(track.country)
                                            .font(Font.custom("Inter24pt-Regular", size: 12))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        if selectedTracks.contains(where: { $0.id == track.id }) {
                                            selectedTracks.removeAll { $0.id == track.id }
                                        } else {
                                            selectedTracks.append(track)
                                        }
                                    }) {
                                        Image(systemName: selectedTracks.contains(where: { $0.id == track.id }) ? "checkmark.circle.fill" : "plus.circle")
                                            .foregroundColor(selectedTracks.contains(where: { $0.id == track.id }) ? .green : .white)
                                            .font(.system(size: 20))
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .frame(maxHeight: 200)
                .background(Color.black.opacity(0.2))
            }
            
            Map(coordinateRegion: $region, annotationItems: Track.sampleTracks) { track in
                MapAnnotation(coordinate: track.coordinates) {
                    TrackAnnotationView(track: track, isSelected: selectedTracks.contains(where: { $0.id == track.id })) {
                        selectedTrack = track
                        showingTrackDetail = true
                    }
                }
            }
            .padding(.top, 20)
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
        .sheet(isPresented: $showingTrackDetail) {
            if let track = selectedTrack {
                TrackDetailScreen(track: track)
            }
        }
        .actionSheet(isPresented: $showingRouteOptions) {
            ActionSheet(
                title: Text("Route Options"),
                message: Text("Choose what you want to do"),
                buttons: [
                    .default(Text("Clear Route")) {
                        selectedTracks.removeAll()
                    },
                    .default(Text("Show Route")) {
                        
                    },
                    .cancel()
                ]
            )
        }
    }
    
    private func centerMapOnTrack(_ track: Track) {
        withAnimation(.easeInOut(duration: 0.5)) {
            region = MKCoordinateRegion(
                center: track.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
            )
        }
    }
    
    private func centerMapOnAllTracks() {
        let tracks = Track.sampleTracks
        guard !tracks.isEmpty else { return }
        
        let latitudes = tracks.map { $0.coordinates.latitude }
        let longitudes = tracks.map { $0.coordinates.longitude }
        
        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        let minLon = longitudes.min() ?? 0
        let maxLon = longitudes.max() ?? 0
        
        let centerLat = (minLat + maxLat) / 2
        let centerLon = (minLon + maxLon) / 2
        let spanLat = (maxLat - minLat) * 1.2
        let spanLon = (maxLon - minLon) * 1.2
        
        withAnimation(.easeInOut(duration: 0.5)) {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon),
                span: MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLon)
            )
        }
    }
}

struct TrackAnnotationView: View {
    let track: Track
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(track.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color.green : Color.white, lineWidth: isSelected ? 3 : 2)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                
                Text(track.name)
                    .font(Font.custom("Inter24pt-Medium", size: 10))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    MapScreen()
}

