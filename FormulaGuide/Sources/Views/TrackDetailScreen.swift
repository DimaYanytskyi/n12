import SwiftUI
import MapKit

struct TrackDetailScreen: View {
    let track: Track
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var region: MKCoordinateRegion
    @Environment(\.dismiss) private var dismiss
    
    init(track: Track) {
        self.track = track
        self._region = State(initialValue: MKCoordinateRegion(
            center: track.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.callout)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Details")
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
                .padding(.top, 21)
                
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .topTrailing) {
                    Image(track.imageName)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                    
                        Button(action: {
                            favoritesManager.toggleTrackFavorite(track.id)
                        }) {
                            Image(.star)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(favoritesManager.isTrackFavorite(track.id) ? Color(red: 255/255, green: 92/255, blue: 0/255) : .white)
                                .frame(width: 30, height: 30)
                        }
                    .padding(14)
                }
                .padding(.top, 21)
                
                VStack(spacing: 0) {
                    Text(track.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Bold", size: 18))
                        .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                        .multilineTextAlignment(.leading)
                            
                    Text(track.country)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 12)
                            
                    Text("Opened")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Bold", size: 18))
                        .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30)
                    Text(track.opened)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 12)

                    Text("Length")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Bold", size: 18))
                        .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30)
                    
                    Text(track.length)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 12)

                    Text("Highlights")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Bold", size: 18))
                        .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30)
                    
                    Text(track.highlights)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 12)

                    Text("History")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Bold", size: 18))
                        .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30)
                    
                    Text(track.history)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 12)

                    Text("Atmosphere")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Bold", size: 18))
                        .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30)
                    
                    Text(track.atmosphere)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("Inter24pt-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 12)
                }
                .padding(15)
                .background(Color.init(red: 101, green: 67, blue: 163, opacit: 0.3))
                .cornerRadius(24)
            }
        }
            .padding(.bottom, 34)
        .padding(.horizontal, 24)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationView {
        TrackDetailScreen(track: Track.sampleTracks[0])
    }
}

