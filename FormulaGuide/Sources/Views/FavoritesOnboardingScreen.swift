import SwiftUI

struct FavoritesOnboardingScreen: View {
    @State private var currentPage = 3
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Your Personal Favorites")
                .font(Font.custom("Inter24pt-Bold", size: 24))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 21)
        
            Text("Create Your Racing Collection")
            .foregroundStyle(.white)
            .font(Font.custom("Inter24pt-Regular", size: 16))
            .multilineTextAlignment(.center)
            .padding(.top, 20)
            
            Image(.personalFavoritesImg)
                .resizable()
                .scaledToFit()
                .padding(.vertical, 12)
            
            HStack(spacing: 4) {
                ForEach(1...3, id: \.self) { index in
                    if index == currentPage {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.init(red: 95, green: 255, blue: 144))
                            .frame(width: 30, height: 5)
                    } else {
                        Circle()
                            .fill(Color.init(red: 95, green: 255, blue: 144))
                            .frame(width: 5, height: 5)
                    }
                }
            }

            Text("Save your favorite tracks and teams in one place. Access them quickly whenever you need inspiration. Personalize your experience and build your racing journey.")
                .font(Font.custom("Inter24pt-Regular", size: 16))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top, 16)
            
            Spacer()
            
            Button {
                onComplete()
            } label: {
                Text("Get Started")
                    .frame(maxWidth: .infinity)
                    .font(Font.custom("Inter24pt-ExtraBold", size: 20))
                    .foregroundStyle(.black)
            }
            .padding(22)
            .background(LinearGradient(colors: [
                Color.init(red: 95, green: 255, blue: 144),
                Color.init(red: 39, green: 246, blue: 140)
            ], startPoint: .top, endPoint: .bottom))
            .cornerRadius(90)
            .padding(.bottom, 2)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    FavoritesOnboardingScreen(onComplete: {})
}
