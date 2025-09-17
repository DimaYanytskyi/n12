import SwiftUI

struct RootView: View {
    @StateObject private var authManager = AuthMain()
    @StateObject private var favoritesManager = FavoritesManager()
    @State private var onboardingStep: OnboardingStep = .authorization
    @State private var isLoading: Bool = true
    
    enum OnboardingStep {
        case authorization
        case chooseAvatars
        case chooseInterests
        case tracksOnboarding
        case teamsOnboarding
        case favoritesOnboarding
    }
    
    private var shouldShowMainApp: Bool {
        return authManager.userSession != nil && authManager.hasCompletedOnboarding
    }
    
    var body: some View {
        if isLoading {
            FirstScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false
                    }
                }
        } else {
            Group {
                if shouldShowMainApp {
                    MainTabView()
                } else {
                    switch onboardingStep {
                    case .authorization:
                        AuthorizationScreen()
                            .onReceive(authManager.$userSession) { user in
                                if let user = user {
                                    if !authManager.hasCompletedOnboarding {
                                        onboardingStep = .chooseAvatars
                                    }
                                } else {
                                    onboardingStep = .authorization
                                }
                            }
                            .onReceive(authManager.$hasCompletedOnboarding) { completed in
                                if completed && authManager.userSession != nil {
                                }
                            }
                        
                    case .chooseAvatars:
                        ChooseAvatarsScreen(onNext: {
                            onboardingStep = .chooseInterests
                        })
                        
                    case .chooseInterests:
                        ChooseInterestsScreen(onNext: {
                            onboardingStep = .tracksOnboarding
                        })
                        
                    case .tracksOnboarding:
                        TracksOnboardingScreen(onNext: {
                            onboardingStep = .teamsOnboarding
                        })
                        
                    case .teamsOnboarding:
                        TeamsOnboardingScreen(onNext: {
                            onboardingStep = .favoritesOnboarding
                        })
                        
                    case .favoritesOnboarding:
                        FavoritesOnboardingScreen(onComplete: {
                            Task { @MainActor in
                                await authManager.completeOnboarding()
                            }
                        })
                    }
                }
            }
            .environmentObject(authManager)
            .environmentObject(favoritesManager)
            .onReceive(authManager.$userSession) { user in
                if user == nil && onboardingStep != .authorization {
                    onboardingStep = .authorization
                } else if user != nil {
                    print("\(String(describing: user?.uid))")
                }
            }
        }
    }
}

#Preview {
    RootView()
}
