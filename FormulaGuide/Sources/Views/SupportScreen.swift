import Foundation
import SwiftUI

struct SupportScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var message: String = ""
    @State private var email: String = ""
    @State private var isAlert: Bool = false
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showImagePickerSheet: Bool = false
    @State private var showingNotifications = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    
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
                
                Text("Support")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
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
            .padding(.top, 21)
            
            ScrollView(showsIndicators: false) {
                Text("Thank you for your inquiry. We will review it and respond to you shortly.")
                    .foregroundStyle(.white.opacity(0.5))
                    .font(.custom("Inter24pt-Regular", size: 16))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                
                Group {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .frame(height: 100)
                            .cornerRadius(12)
                    } else {
                        Image(.attachImag)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .padding(.bottom, 24)
                .onTapGesture {
                    showImagePickerSheet = true
                }
                
                TextField("", text: $email, prompt:
                            Text("Email")
                    .font(.custom("Inter24pt-Regular", size: 16))
                    .foregroundColor(.white)
                )
                .font(.custom("Inter24pt-Regular", size: 16))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.vertical, 21)
                .padding(.horizontal, 16)
                .foregroundColor(.white)
                .background(Color.init(red: 18, green: 18, blue: 31))
                .cornerRadius(40)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $message)
                        .font(.custom("Inter24pt-Regular", size: 16))
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .padding(12)
                    
                    if message.isEmpty {
                        Text("Message")
                            .font(.custom("Inter24pt-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding(20)
                    }
                }
                .background(.black.opacity(0.1))
                .frame(minHeight: 200)
                .background(Color.init(red: 18, green: 18, blue: 31))
                .cornerRadius(24)
                .padding(.vertical, 20)
                
                Button {
                    isAlert = true
                } label: {
                    Text("Send Message")
                        .foregroundStyle(.black)
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 21)
                .background(LinearGradient(colors: [
                    Color.init(red: 95, green: 255, blue: 144),
                    Color.init(red: 39, green: 246, blue: 140)
                ], startPoint: .top, endPoint: .bottom))
                .cornerRadius(90)
                .alert("", isPresented: $isAlert) {
                    Button("OK", role: .cancel) {
                        
                    }
                } message: {
                    Text(email.contains(where: { $0 == "@" }) ? "Thank you for your message! Our team will review it and reply promptly." : "A valid email address is required.")
                }
                
            }
            .padding(.bottom, 3)
        }
        .padding(.horizontal, 21)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.baseBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showImagePickerSheet) {
            ImagePickerBottomSheet(showImagePickerSheet: $showImagePickerSheet, showImagePicker: $showImagePicker, imageSource: $imageSource)
                .presentationDetents([.height(230)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: imageSource)
        }
        .background(
            NavigationLink(destination: NotificationsScreen(), isActive: $showingNotifications) {
                EmptyView()
            }
        )
    }
}

#Preview {
    SupportScreen()
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    let sourceType: UIImagePickerController.SourceType
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct ImagePickerBottomSheet: View {
    @Binding var showImagePickerSheet: Bool
    @Binding var showImagePicker: Bool
    @Binding var imageSource: UIImagePickerController.SourceType
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                Text("Select an Option")
                    .font(Font.custom("Inter24pt-Bold", size: 24))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Text("Select how you want to add an image")
                    .font(.custom("Inter24pt-Regular", size: 16))
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 20) {
                Button("Gallery") {
                    imageSource = .photoLibrary
                    showImagePickerSheet = false
                    showImagePicker = true
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .font(.custom("Inter24pt-ExtraBold", size: 20))
                .cornerRadius(40)
                .padding(.vertical, 21)
                .background(LinearGradient(colors: [
                    Color.init(red: 95, green: 255, blue: 144),
                    Color.init(red: 39, green: 246, blue: 140)
                ], startPoint: .top, endPoint: .bottom))
                .cornerRadius(90)
                
                Button("Camera") {
                    imageSource = .camera
                    showImagePickerSheet = false
                    showImagePicker = true
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .font(.custom("Inter24pt-ExtraBold", size: 20))
                .cornerRadius(40)
                .padding(.vertical, 21)
                .background(LinearGradient(colors: [
                    Color.init(red: 255, green: 92, blue: 0),
                    Color.init(red: 255, green: 72, blue: 0)
                ], startPoint: .top, endPoint: .bottom))
                .cornerRadius(90)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.init(red: 114, green: 42, blue: 218))
    }
}
