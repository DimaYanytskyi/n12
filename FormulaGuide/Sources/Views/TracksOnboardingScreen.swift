import SwiftUI

struct TracksOnboardingScreen: View {
    @State private var currentPage = 1
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Tracks Around the World")
                .font(.custom("Inter24pt-Bold", size: 24))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
                .background(Color(red: 42, green: 59, blue: 76))
                .padding(.horizontal, -24)
        
            Text("Discover Legendary Race Tracks")
                .font(.custom("Inter24pt-Regular", size: 16))
                .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Image(.tracksAroundImg)
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
                
                Text("Explore famous circuits from every corner of the globe. Learn key facts about their history, design, and events. Find the tracks that inspire your passion for racing.")
                    .font(.custom("Inter24pt-Regular", size: 16))
                    .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                
                Spacer()
                
                Button {
                    onNext()
                } label: {
                    Text("Next Step")
                        .frame(maxWidth: .infinity)
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .foregroundStyle(.white)
                }
                .padding(22)
                .background(Color(red: 0, green: 86, blue: 254))
                .cornerRadius(14)
                
                Button {
                    onNext()
                } label: {
                    Text("Skip")
                        .frame(maxWidth: .infinity)
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .foregroundStyle(Color(red: 42, green: 59, blue: 76))
                }
                .padding(22)
                .background(Color(red: 42, green: 59, blue: 76, opacit: 0.1))
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
    TracksOnboardingScreen(onNext: {})
}
