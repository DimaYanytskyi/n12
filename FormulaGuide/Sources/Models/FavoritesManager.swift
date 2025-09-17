import Foundation
import SwiftUI

@MainActor
class FavoritesManager: ObservableObject {
    @Published var favoriteTracks: Set<UUID> = []
    @Published var favoriteTeams: Set<UUID> = []
    
    private let userDefaults = UserDefaults.standard
    private let tracksKey = "favoriteTracks"
    private let teamsKey = "favoriteTeams"
    
    init() {
        loadFavorites()
    }
    
    func toggleTrackFavorite(_ trackId: UUID) {
        if favoriteTracks.contains(trackId) {
            favoriteTracks.remove(trackId)
        } else {
            favoriteTracks.insert(trackId)
        }
        saveFavorites()
    }
    
    func isTrackFavorite(_ trackId: UUID) -> Bool {
        return favoriteTracks.contains(trackId)
    }
    
    func getFavoriteTracks() -> [Track] {
        return Track.sampleTracks.filter { favoriteTracks.contains($0.id) }
    }
    
    func toggleTeamFavorite(_ teamId: UUID) {
        if favoriteTeams.contains(teamId) {
            favoriteTeams.remove(teamId)
        } else {
            favoriteTeams.insert(teamId)
        }
        saveFavorites()
    }
    
    func isTeamFavorite(_ teamId: UUID) -> Bool {
        return favoriteTeams.contains(teamId)
    }
    
    func getFavoriteTeams() -> [Team] {
        return Team.sampleTeams.filter { favoriteTeams.contains($0.id) }
    }
    
    private func saveFavorites() {
        let trackIds = Array(favoriteTracks).map { $0.uuidString }
        let teamIds = Array(favoriteTeams).map { $0.uuidString }
        
        userDefaults.set(trackIds, forKey: tracksKey)
        userDefaults.set(teamIds, forKey: teamsKey)
    }
    
    private func loadFavorites() {
        if let trackIds = userDefaults.stringArray(forKey: tracksKey) {
            favoriteTracks = Set(trackIds.compactMap { UUID(uuidString: $0) })
        }
        
        if let teamIds = userDefaults.stringArray(forKey: teamsKey) {
            favoriteTeams = Set(teamIds.compactMap { UUID(uuidString: $0) })
        }
    }
    
    func clearAllFavorites() {
        favoriteTracks.removeAll()
        favoriteTeams.removeAll()
        saveFavorites()
    }
}
