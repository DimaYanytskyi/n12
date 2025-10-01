
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
            Text("Choose Interests")
                .font(.custom("Inter24pt-Bold", size: 24))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
                .background(Color(red: 42, green: 59, blue: 76))
                .padding(.horizontal, -24)
            
            Text("Select the items that interest you. You can select several items at once.")
                .font(.custom("Inter24pt-Regular", size: 16))
                .foregroundStyle(Color(red: 18, green: 18, blue: 31))
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
                    .foregroundStyle(.white)
            }
            .padding(22)
            .background(Color(red: 0, green: 86, blue: 254))
            .cornerRadius(14)
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
                                ? Color(red: 116, green: 182, blue: 3)
                                : Color.clear,
                                lineWidth: interest.isSelected ? 3 : 0
                            )
                    )
                    .shadow(color: interest.isSelected
                            ? Color(red: 116, green: 182, blue: 3, opacit: 0.5)
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
