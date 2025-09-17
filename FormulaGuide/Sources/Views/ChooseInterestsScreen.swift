
import SwiftUI

struct InterestCard: Identifiable {
    let id = UUID()
    let number: String
    let title: String
    let imageName: String
    var isSelected: Bool
}

struct ChooseInterestsScreen: View {
    let onNext: () -> Void
    @State private var interests: [InterestCard] = [
        InterestCard(number: "01", title: "Formula 1", imageName: "interes1", isSelected: false),
        InterestCard(number: "02", title: "Historic tracks", imageName: "interes2", isSelected: false),
        InterestCard(number: "03", title: "Modern tracks", imageName: "interes3", isSelected: false),
        InterestCard(number: "04", title: "Teams", imageName: "interes4", isSelected: false),
        InterestCard(number: "05", title: "Drivers", imageName: "interes5", isSelected: false)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Text("Choose Interests")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()

            }
            .padding(.top, 21)
            
            Text("Select the items that interest you. You can select several items at once.")
                .font(Font.custom("Inter24pt-Regular", size: 16))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                ForEach($interests) { $interest in
                    InterestCardView(interest: $interest)
                }
            }
            .padding(.top, 32)
            
            Spacer()

            Button {
                onNext()
            } label: {
                Text("Done")
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

struct InterestCardView: View {
    @Binding var interest: InterestCard
    
    var body: some View {
        Button(action: {
            interest.isSelected.toggle()
        }) {
            VStack(spacing: 12) {
                Image(interest.imageName)
                    .resizable()
                    .scaledToFill()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                interest.isSelected
                                ? Color.init(red: 95, green: 255, blue: 144)
                                : Color.clear,
                                lineWidth: interest.isSelected ? 3 : 0
                            )
                    )
                    .shadow(color: interest.isSelected
                            ? Color.init(red: 95, green: 255, blue: 144, opacit: 0.5)
                            : Color.clear
                            , radius: 5, x: 0, y: 0
                    )
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ChooseInterestsScreen(onNext: {})
}
