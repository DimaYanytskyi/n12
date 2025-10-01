import SwiftUI

struct FavoritesOnboardingScreen: View {
    @State private var currentPage = 3
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Your Personal Favorites")
                .font(.custom("Inter24pt-Bold", size: 24))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
                .background(Color(red: 42, green: 59, blue: 76))
                .padding(.horizontal, -24)
        
            Text("Create Your Racing Collection")
                .font(.custom("Inter24pt-Regular", size: 16))
                .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Image(.personalFavoritesImg)
                .resizable()
                .scaledToFit()
                .padding(.top, 12)
            
            VStack {
                HStack(spacing: 4) {
                    ForEach(1...3, id: \.self) { index in
                        if index == currentPage {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color(red: 116, green: 182, blue: 3))
                                .frame(width: 30, height: 5)
                        } else {
                            Circle()
                                .fill(Color(red: 116, green: 182, blue: 3))
                                .frame(width: 5, height: 5)
                        }
                    }
                }

                Text("Save your favorite tracks and teams in one place. Access them quickly whenever you need inspiration. Personalize your experience and build your racing journey.")
                    .font(.custom("Inter24pt-Regular", size: 16))
                    .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                
                Spacer()
                
                Button {
                    onComplete()
                } label: {
                    Text("Get Started")
                        .frame(maxWidth: .infinity)
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .foregroundStyle(.white)
                }
                .padding(22)
                .background(Color(red: 0, green: 86, blue: 254))
                .cornerRadius(14)
            }
            .padding(10)
            .background(.white)
            .cornerRadius(20)
            .padding(.top, 30)
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
