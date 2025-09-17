import SwiftUI

struct TeamsScreen: View {
    @State private var searchText = ""
    @State private var selectedCountry: String = ""
    @State private var selectedTeam: Team?
    
    private let teams = Team.sampleTeams
    private let countries = Array(Set(Team.sampleTeams.map { $0.country })).sorted()
    
    var filteredTeams: [Team] {
        var filtered = teams
        
        if !searchText.isEmpty {
            filtered = filtered.filter { team in
                team.name.localizedCaseInsensitiveContains(searchText) ||
                team.drivers.joined().localizedCaseInsensitiveContains(searchText)
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
                Text("Teams")
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
                    ForEach(filteredTeams) { team in
                        NavigationLink(destination: TeamDetailScreen(team: team)) {
                            TeamCard(team: team)
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

struct TeamCard: View {
    let team: Team
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(team.imageName)
                .resizable()
                .scaledToFill()
            
            Button(action: {
                favoritesManager.toggleTeamFavorite(team.id)
            }) {
                Image(.star)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(favoritesManager.isTeamFavorite(team.id) ? Color(red: 255/255, green: 92/255, blue: 0/255) : .white)
                    .frame(width: 24, height: 24)
            }
            .padding(12)
        }
    }
}

#Preview {
    TeamsScreen()
}
