
import SwiftUI
import WebKit
import StoreKit

struct SettingsScreen: View {
    @State private var showingNotifications = false
    @State private var showingSupport = false
    @State private var isPresentPolicy = false
    @State private var isPresentTerm = false
    @State private var isShareSheetPresented = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
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
                
                Text("Settings")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image("")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(Color(red: 42, green: 59, blue: 76))
            .padding(.horizontal, -24)
            
            VStack(spacing: 14) {
                SettingsActionButton(title: "Rate App", icon: .arrowCircleRight) {
                    requestAppReview()
                }
                
                SettingsActionButton(title: "Share with Friends", icon: .arrowCircleRight) {
                    isShareSheetPresented = true
                }
                .sheet(isPresented: $isShareSheetPresented) {
                    ShareSheet(items: [URL(string: "https://apps.apple.com/app/id6752661716")!])
                }
                
                SettingsActionButton(title: "Terms of Service", icon: .arrowCircleRight) {
                    isPresentTerm = true
                }
                .sheet(isPresented: $isPresentTerm) {
                    NavigationStack {
                        WebView(url: URL(string: "https://sites.google.com/view/one-racingexplorer/terms-of-service")!)
                            .ignoresSafeArea()
                            .navigationTitle("Privacy Policy")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                SettingsActionButton(title: "Privacy Policy", icon: .arrowCircleRight) {
                    isPresentPolicy = true
                }
                .sheet(isPresented: $isPresentPolicy) {
                    NavigationStack {
                        WebView(url: URL(string: "https://sites.google.com/view/one-racingexplorer/privacy-policy")!)
                            .ignoresSafeArea()
                            .navigationTitle("Privacy Policy")
                            .navigationBarTitleDisplayMode(.inline)
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
        .navigationBarBackButtonHidden(true)
    }
    
    func requestAppReview() {
       if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
           SKStoreReviewController.requestReview(in: scene)
       }
   }
}

#Preview {
    SettingsScreen()
}

struct WebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


struct SettingsActionButton: View {
    let title: String
    let icon: ImageResource
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(Font.custom("Inter24pt-Bold", size: 16))
                    .foregroundColor(Color.init(red: 18, green: 18, blue: 31))
                
                Spacer()
                
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            }
            .padding(16)
            .background(.white)
            .cornerRadius(10)
        }
    }
}
