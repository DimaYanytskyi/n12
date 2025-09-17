import SwiftUI

struct ChooseAvatarsScreen: View {
    @EnvironmentObject var authManager: AuthMain
    @State private var selectedAvatarIndex: Int
    let onNext: () -> Void
    
    private let avatars = [
        Avatar(name: "icon1", displayName: "Avatar #1"),
        Avatar(name: "icon2", displayName: "Avatar #2"),
        Avatar(name: "icon3", displayName: "Avatar #3"),
        Avatar(name: "icon4", displayName: "Avatar #4"),
        Avatar(name: "icon5", displayName: "Avatar #5"),
        Avatar(name: "icon6", displayName: "Avatar #6")
    ]
    
    init(onNext: @escaping () -> Void) {
        self.onNext = onNext
        self._selectedAvatarIndex = State(initialValue: 0)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Choose Avatars")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 21)
            
            Text("Select your avatar, which you will use in the application.")
                .font(Font.custom("Inter24pt-Regular", size: 16))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Spacer()
            
            ScrollViewReader { proxy in
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 2) {
                            ForEach(0..<avatars.count, id: \.self) { index in
                                Image(avatars[index].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .id(index)
                                    .scaleEffect(selectedAvatarIndex == index ? 1.0 : 0.8)
                                    .opacity(selectedAvatarIndex == index ? 1.0 : 0.6)
                                    .animation(.easeInOut(duration: 0.3), value: selectedAvatarIndex)
                            }
                        }
                        .padding(.horizontal, 100)
                    }
                    .onChange(of: selectedAvatarIndex) { newValue in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                        authManager.saveSelectedAvatar(newValue)
                    }
                    .onAppear {
                        selectedAvatarIndex = authManager.selectedAvatarIndex
                    }
                    
                    Image(.subtract)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320, height: 320)
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, -24)
            
            HStack {
                Button {
                    if selectedAvatarIndex > 0 {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedAvatarIndex -= 1
                        }
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color.init(red: 95, green: 255, blue: 144))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.init(red: 95, green: 255, blue: 144, opacit: 0.2))
                        .clipShape(Circle())
                }
                .opacity(selectedAvatarIndex > 0 ? 1.0 : 0.5)
                .disabled(selectedAvatarIndex == 0)
                Spacer()
                HStack(spacing: 4) {
                    ForEach(0..<avatars.count, id: \.self) { index in
                        if index == selectedAvatarIndex {
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
                Spacer()
                Button {
                    if selectedAvatarIndex < avatars.count - 1 {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedAvatarIndex += 1
                        }
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color.init(red: 95, green: 255, blue: 144))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.init(red: 95, green: 255, blue: 144, opacit: 0.2))
                        .clipShape(Circle())
                }
                .opacity(selectedAvatarIndex < avatars.count - 1 ? 1.0 : 0.5)
                .disabled(selectedAvatarIndex == avatars.count - 1)
            }
            .padding(.top, 20)

            Spacer()
            
            Button {
                onNext()
            } label: {
                Text("Continue")
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

struct Avatar {
    let name: String
    let displayName: String
}

#Preview {
    ChooseAvatarsScreen(onNext: {})
        .environmentObject(AuthMain())
}
