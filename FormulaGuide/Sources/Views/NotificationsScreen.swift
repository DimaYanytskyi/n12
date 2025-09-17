import SwiftUI

struct NotificationsScreen: View {
    @State private var notificationsEnabled = true
    @State private var vibrationEnabled = true
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.callout)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text("Notifications")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Color.clear
                    .frame(width: 30, height: 30)
            }
            .padding(.top, 21)
            
            Text("All updates and notifications in the application will be displayed here. There are currently no entries here.")
                .font(Font.custom("Inter24pt-Regular", size: 16))
                .foregroundStyle(.white.opacity(0.5))
                .padding(.top, 20)
            
            VStack(spacing: 14) {
                NotificationToggleRow(
                    title: "Notifications",
                    isEnabled: notificationsEnabled
                ) {
                    notificationsEnabled.toggle()
                }
                
                NotificationToggleRow(
                    title: "Vibration",
                    isEnabled: vibrationEnabled
                ) {
                    vibrationEnabled.toggle()
                }
            }
            .padding(.top, 24)
            
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
    NotificationsScreen()
}

struct NotificationToggleRow: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.custom("Inter24pt-Bold", size: 16))
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(isEnabled ? Color.init(red: 39, green: 246, blue: 140) : Color.init(red: 114, green: 42, blue: 218))
                        .frame(width: 50, height: 30)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 26, height: 26)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                        .offset(x: isEnabled ? 10 : -10)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .animation(.easeInOut(duration: 0.2), value: isEnabled)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.init(red: 18, green: 18, blue: 31))
        )
    }
}
