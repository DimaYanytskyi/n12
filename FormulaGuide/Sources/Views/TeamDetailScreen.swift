import SwiftUI
import MapKit

struct TeamDetailScreen: View {
    let team: Team
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var region: MKCoordinateRegion
    @Environment(\.dismiss) private var dismiss
    
    init(team: Team) {
        self.team = team
        self._region = State(initialValue: MKCoordinateRegion(
            center: team.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
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
                        Image(team.imageName)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                        
                        Button(action: {
                            favoritesManager.toggleTeamFavorite(team.id)
                        }) {
                            Image(.star)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(favoritesManager.isTeamFavorite(team.id) ? Color(red: 255/255, green: 92/255, blue: 0/255) : .white)
                                .frame(width: 30, height: 30)
                        }
                        .padding(14)
                    }
                    .padding(.top, 21)
                    
                    VStack(spacing: 0) {
                        Text("Base")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Bold", size: 18))
                            .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                            .multilineTextAlignment(.leading)
                                
                        Text(team.base)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Regular", size: 15))
                            .foregroundColor(.white)
                            .padding(.top, 12)
                                
                        Text("Founded")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Bold", size: 18))
                            .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30)
                        Text(team.founded)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Regular", size: 15))
                            .foregroundColor(.white)
                            .padding(.top, 12)

                        Text("Drivers")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Bold", size: 18))
                            .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30)
                        
                        Text(team.drivers.formatted())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Regular", size: 15))
                            .foregroundColor(.white)
                            .padding(.top, 12)

                        Text("Car")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Bold", size: 18))
                            .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30)
                        
                        Text(team.car)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Regular", size: 15))
                            .foregroundColor(.white)
                            .padding(.top, 12)

                        Text("Achievements")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Inter24pt-Bold", size: 18))
                            .foregroundColor(Color.init(red: 39, green: 246, blue: 140))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30)
                        
                        Text(team.achievements)
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
                        
                        Text(team.highlights)
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
        TeamDetailScreen(team: Team.sampleTeams[0])
    }
}

