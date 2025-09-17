import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @State private var showMainApp = false
    
    private let onboardingSteps = [
        OnboardingStep(
            title: "Tracks Around the World",
            subtitle: "Discover Legendary Race Tracks",
            description: "Explore famous circuits from every corner of the globe. Learn key facts about their history, design, and events.",
            image: "car.fill"
        ),
        OnboardingStep(
            title: "Formula 1 Teams",
            subtitle: "Get to Know F1 Teams",
            description: "Browse detailed profiles of Formula 1 teams and their drivers. See the cars, colors, and achievements.",
            image: "person.3.fill"
        ),
        OnboardingStep(
            title: "Your Personal Favorites",
            subtitle: "Create Your Racing Collection",
            description: "Save your favorite tracks and teams in one place. Access them quickly whenever you need inspiration.",
            image: "heart.fill"
        )
    ]
    
    var body: some View {
        if showMainApp {
            MainTabView()
        } else {
                    VStack(spacing: 24) {
            HStack(spacing: 8) {
                ForEach(0..<onboardingSteps.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentStep ? Color.green : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 32)
            
            Spacer()
            
            VStack(spacing: 24) {
                Image(systemName: onboardingSteps[currentStep].image)
                    .font(.system(size: 80))
                    .foregroundColor(Color.green)
                
                VStack(spacing: 16) {
                    Text(onboardingSteps[currentStep].title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                    Text(onboardingSteps[currentStep].subtitle)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                
                Text(onboardingSteps[currentStep].description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                if currentStep < onboardingSteps.count - 1 {
                    Button("Next") {
                        withAnimation {
                            currentStep += 1
                        }
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.green)
                    .cornerRadius(28)
                    .scaleEffect(1.0)
                    
                    Button("Skip") {
                        showMainApp = true
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.purple.opacity(0.8))
                    .cornerRadius(24)
                    .scaleEffect(1.0)
                } else {
                    Button("Get Started") {
                        showMainApp = true
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.green)
                    .cornerRadius(28)
                    .scaleEffect(1.0)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            }
            .background(
                Image("baseBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
        }
    }
}

struct OnboardingStep {
    let title: String
    let subtitle: String
    let description: String
    let image: String
}

#Preview {
    OnboardingView()
}
