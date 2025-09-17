import SwiftUI

struct DetailsScreen: View {
    let section1Title: String
    let section1Value: String

    let section2Title: String = ""
    let section2Value: String = ""

    let section3Title: String = ""
    let section3Value: String = ""

    let section4Title: String = ""
    let section4Value: String = ""

    let section5Title: String = ""
    let section5Value: String = ""

    let section6Title: String = ""
    let section6Value: String = ""
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    
                }) {
                    Image(systemName: "chevron.left")
                        .font(.callout)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text("Details")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(.notificationButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            .padding(.top, 21)
            
            ScrollView(showsIndicators: false) {
                Text(section1Title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Bold", size: 18))
                    .foregroundStyle(Color.init(red: 39, green: 246, blue: 140))
                    .padding(.bottom, 12)
                Text(section1Value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Regular", size: 15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                Text(section2Title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Bold", size: 18))
                    .foregroundStyle(Color.init(red: 39, green: 246, blue: 140))
                    .padding(.bottom, 12)
                Text(section2Value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Regular", size: 15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                Text(section3Title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Bold", size: 18))
                    .foregroundStyle(Color.init(red: 39, green: 246, blue: 140))
                    .padding(.bottom, 12)
                Text(section3Value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Regular", size: 15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                Text(section4Title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Bold", size: 18))
                    .foregroundStyle(Color.init(red: 39, green: 246, blue: 140))
                    .padding(.bottom, 12)
                Text(section4Value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Regular", size: 15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                Text(section5Title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Bold", size: 18))
                    .foregroundStyle(Color.init(red: 39, green: 246, blue: 140))
                    .padding(.bottom, 12)
                Text(section5Value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Regular", size: 15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                Text(section6Title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Bold", size: 18))
                    .foregroundStyle(Color.init(red: 39, green: 246, blue: 140))
                    .padding(.bottom, 12)
                Text(section6Value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("Inter24pt-Regular", size: 15))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
            }
            .padding(15)
            .background(Color.init(red: 101, green: 67, blue: 163, opacit: 0.3))
            .cornerRadius(24)
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 21)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    DetailsScreen(section1Title: "1q23", section1Value: "12rfds")
}
