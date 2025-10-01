import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var authManager: AuthMain
    @Environment(\.dismiss) private var dismiss
    @State private var isAlertPresent = false
    
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, EEE"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Date())
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Profile")
                    .font(.custom("Inter24pt-Bold", size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink(destination: NotificationsScreen()) {
                    Image(.notificationButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(Color(red: 42, green: 59, blue: 76))
            .padding(.horizontal, -24)
            
            VStack(spacing: 16) {
                Image(authManager.getSelectedAvatarName())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text(authManager.currentuser?.name ?? "User")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .foregroundColor(Color(red: 18, green: 18, blue: 31))
                
                Text(currentDate)
                    .font(Font.custom("Inter24pt-Regular", size: 14))
                    .foregroundColor(Color(red: 18, green: 18, blue: 31, opacit: 0.5))
            }
            .padding(.top, 24)
            
            Spacer()
            
            VStack(spacing: 16) {
                ProfileMenuItem(
                    title: "Support",
                    destination: AnyView(SupportScreen())
                )
                
                ProfileMenuItem(
                    title: "Settings",
                    destination: AnyView(SettingsScreen())
                )
                
                HStack(spacing: 16) {
                    ActionButton(
                        title: "Log Out",
                        icon: .logoutButton
                    ) {
                        authManager.signOut()
                    }
                    
                    ActionButton(
                        title: "Delete",
                        icon: .trashButton
                    ) {
                        isAlertPresent = true
                    }
                    .alert("Are you sure?", isPresented: $isAlertPresent) {
                        Button("Delete", role: .destructive) {
                            authManager.deleteUserAccount { result in
                                switch result {
                                case .success():
                                    break
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            
                        }
                    } message: {
                        Text("Are you sure you want to delete the account?")
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(AuthMain())
}


struct ProfileMenuItem: View {
    let title: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(title)
                    .font(Font.custom("Inter24pt-Bold", size: 16))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(.arrowCircleRight)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            }
            .padding(16)
            .background((Color(red: 18, green: 18, blue: 31)))
            .cornerRadius(10)
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: ImageResource
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(Font.custom("Inter24pt-Bold", size: 16))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            }
            .padding(16)
            .background((Color.init(red: 18, green: 18, blue: 31)))
            .cornerRadius(10)
        }
    }
}
