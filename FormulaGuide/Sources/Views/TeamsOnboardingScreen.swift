import SwiftUI

struct TeamsOnboardingScreen: View {
    @State private var currentPage = 2
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Formula 1 Teams")
                .font(Font.custom("Inter24pt-Bold", size: 24))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 21)
        
            Text("Get to Know F1 Teams")
            .foregroundStyle(.white)
            .font(Font.custom("Inter24pt-Regular", size: 16))
            .multilineTextAlignment(.center)
            .padding(.top, 20)
            
            Image(.formula1TeamsImg)
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
            
            Text("Browse detailed profiles of Formula 1 teams and their drivers. See the cars, colors, and achievements that define each team. Stay connected with the world of professional racing.")
                .font(Font.custom("Inter24pt-Regular", size: 16))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top, 16)
            
            Spacer()
            
            Button {
                onNext()
            } label: {
                Text("Next Step")
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
                
            Button {
                onNext()
            } label: {
                Text("Skip")
                    .frame(maxWidth: .infinity)
                    .font(Font.custom("Inter24pt-ExtraBold", size: 20))
                    .foregroundStyle(.white)
            }
            .padding(22)
            .background(.white.opacity(0.14))
            .cornerRadius(90)
            .padding(.top, 20)
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
    TeamsOnboardingScreen(onNext: {})
}
