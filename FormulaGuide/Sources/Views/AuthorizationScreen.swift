import SwiftUI

struct AuthorizationScreen: View {
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    
    @State private var isNotificationShown = false
    @State private var isAlertShown = false
    @State private var isAuth = true
    @EnvironmentObject var authManager: AuthMain
    
    var body: some View {
        if isAuth {
            authorisationView
                .alert(isPresented: $isAlertShown) {
                    Alert(
                        title: Text("Error"),
                        message: Text(authManager.text),
                        dismissButton: .cancel()
                    )
                }
        } else {
            registrationView
                .alert(isPresented: $isNotificationShown) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Please ensure your email address is valid and not empty, your password is at least 6 characters long, and your confirmation password matches your password."),
                        dismissButton: .cancel()
                    )
                }
        }
    }
    
    var registrationView: some View {
        VStack(spacing: 0) {
            Text("Create Account")
                .frame(maxWidth: .infinity)
                .font(.custom("Inter24pt-Bold", size: 24))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
                .background(Color(red: 42, green: 59, blue: 76))
                .padding(.horizontal, -24)
            
                Text("Create your account to receive feedback and notifications in the app")
                    .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                    .font(.custom("Inter24pt-Regular", size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                TextField("", text: $name, prompt:
                            Text("Username")
                    .font(.custom("Inter24pt-Medium", size: 18))
                    .foregroundColor(Color(red: 37, green: 44, blue: 54, opacit: 0.4))
                )
                .font(.custom("Inter24pt-Medium", size: 18))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(Color(red: 37, green: 44, blue: 54))
                .padding(20)
                .background(!name.isEmpty
                            ? .white
                            : Color.init(red: 239, green: 239, blue: 239)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(!name.isEmpty ? .black : .clear, lineWidth: 2)
                        .shadow(color: !name.isEmpty ? Color.init(red: 0, green: 209, blue: 246) : .clear,
                                radius: 4, x: 0, y: 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 20)
                
                TextField("", text: $email, prompt:
                    Text("Email")
                    .font(.custom("Inter24pt-Medium", size: 18))
                    .foregroundColor(Color(red: 37, green: 44, blue: 54, opacit: 0.4))
                )
                .font(.custom("Inter24pt-Medium", size: 18))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(Color(red: 37, green: 44, blue: 54))
                .padding(20)
                .background(!email.isEmpty
                            ? .white
                            : Color.init(red: 239, green: 239, blue: 239)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(!email.isEmpty ? .black : .clear, lineWidth: 2)
                        .shadow(color: !email.isEmpty ? Color.init(red: 0, green: 209, blue: 246) : .clear,
                                radius: 4, x: 0, y: 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 20)
                
                SecureField("", text: $password, prompt:
                        Text("Password")
                    .font(.custom("Inter24pt-Medium", size: 18))
                    .foregroundColor(Color(red: 37, green: 44, blue: 54, opacit: 0.4))
                )
                .font(.custom("Inter24pt-Medium", size: 18))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(Color(red: 37, green: 44, blue: 54))
                .padding(20)
                .background(!password.isEmpty
                            ? .white
                            : Color.init(red: 239, green: 239, blue: 239)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(!password.isEmpty ? Color(red: 43, green: 247, blue: 139) : .clear, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 20)
                
                
                Button {
                    if !name.isEmpty && !password.isEmpty && !email.isEmpty {
                        if isValid {
                            Task {
                                do {
                                    try await authManager.createUser(withEmail: email, password: password, name: name)
                                    if !authManager.text.isEmpty {
                                        isAlertShown = true
                                    }
                                } catch {
                                    isAlertShown = true
                                }
                            }
                        } else {
                            isNotificationShown.toggle()
                        }
                    }
                } label: {
                    Text("Create Account")
                        .foregroundStyle(email.isEmpty || name.isEmpty || password.isEmpty
                                         ? .white.opacity(0.5)
                                         : .white
                        )
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                .background(email.isEmpty || name.isEmpty || password.isEmpty
                            ? Color.init(red: 93, green: 93, blue: 93, opacit: 1)
                            : Color.init(red: 0, green: 86, blue: 254, opacit: 1)
                )
                .cornerRadius(14)
                .padding(.top, 20)
                
                Button(action: {
                    isAuth = true
                }, label: {
                    HStack(spacing: 4) {
                        Text("Already created an account?")
                        .font(.custom("Inter24pt-Regular", size: 15))
                        .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                        
                        Text("Log in")
                        .font(.custom("Inter24pt-ExtraBold", size: 15))
                        .foregroundColor(Color.init(red: 114, green: 185, blue: 1))
                    }
                })
                .padding(.top, 20)
                
                Spacer()
                
                Button {
                    Task {
                        await authManager.signInAnonymously()
                    }
                } label: {
                    Text("Stay as Guest")
                        .foregroundStyle(Color(red: 42, green: 59, blue: 76))
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                .background(Color(red: 42, green: 59, blue: 76, opacit: 0.1))
                .cornerRadius(14)
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
    
    var authorisationView: some View {
        VStack(spacing: 0) {
            Text("Log In to Account")
                .frame(maxWidth: .infinity)
                .font(.custom("Inter24pt-Bold", size: 24))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
                .background(Color(red: 42, green: 59, blue: 76))
                .padding(.horizontal, -24)
            
                Text("Log in to the account you have already created by filling in the fields below")
                .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                .font(.custom("Inter24pt-Regular", size: 16))
                .multilineTextAlignment(.center)
                .padding(.top, 20)

                TextField("", text: $email, prompt:
                            Text("Email")
                    .font(.custom("Inter24pt-Medium", size: 18))
                    .foregroundColor(Color(red: 37, green: 44, blue: 54, opacit: 0.4))
                )
                .font(.custom("Inter24pt-Medium", size: 18))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(Color(red: 37, green: 44, blue: 54))
                .padding(20)
                .background(!email.isEmpty
                            ? .white
                            : Color.init(red: 239, green: 239, blue: 239)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(!email.isEmpty ? .black : .clear, lineWidth: 2)
                        .shadow(color: !email.isEmpty ? Color.init(red: 0, green: 209, blue: 246) : .clear,
                                radius: 4, x: 0, y: 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 20)
                
                SecureField("", text: $password, prompt:
                                Text("Password")
                    .font(.custom("Inter24pt-Medium", size: 18))
                    .foregroundColor(Color(red: 37, green: 44, blue: 54, opacit: 0.4))
                )
                .font(.custom("Inter24pt-Medium", size: 18))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(Color(red: 37, green: 44, blue: 54))
                .padding(20)
                .background(!password.isEmpty
                            ? .white
                            : Color.init(red: 239, green: 239, blue: 239)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(!password.isEmpty ? Color(red: 43, green: 247, blue: 139) : .clear, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 20)
                
                Button {
                    if !email.isEmpty && !password.isEmpty {
                        Task {
                            do {
                                try await authManager.signIn(email: email, password: password)
                                if !authManager.text.isEmpty {
                                    isAlertShown = true
                                }
                            } catch {
                                isAlertShown = true
                            }
                        }
                    }
                } label: {
                    Text("Log In")
                        .foregroundStyle(email.isEmpty || password.isEmpty
                                         ? .white.opacity(0.5)
                                         : .white
                        )
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                .background(email.isEmpty || password.isEmpty
                            ? Color.init(red: 93, green: 93, blue: 93, opacit: 1)
                            : Color.init(red: 0, green: 86, blue: 254, opacit: 1)
                )
                .cornerRadius(14)
                .padding(.top, 20)
                
                Button(action: {
                    isAuth = false
                }, label: {
                    HStack(spacing: 4) {
                        Text("Still don't have an account?")
                            .font(.custom("Inter24pt-Regular", size: 15))
                            .foregroundStyle(Color(red: 18, green: 18, blue: 31))
                        
                            Text("Create one")
                            .font(.custom("Inter24pt-ExtraBold", size: 15))
                            .foregroundColor(Color(red: 114, green: 185, blue: 1))
                    }
                })
                .padding(.top, 20)
                
                Spacer()
                
                Button {
                    Task {
                        await authManager.signInAnonymously()
                    }
                } label: {
                    Text("Stay as Guest")
                        .foregroundStyle(Color(red: 42, green: 59, blue: 76))
                        .font(.custom("Inter24pt-ExtraBold", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                .background(Color(red: 42, green: 59, blue: 76, opacit: 0.1))
                .cornerRadius(14)
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
}

#Preview {
    AuthorizationScreen()
        .environmentObject(AuthMain())
}

protocol AuthProtocol {
    var isValid: Bool { get }
}


extension AuthorizationScreen: AuthProtocol {
    var isValid: Bool {
        return !name.isEmpty
        && !password.isEmpty
        && password.count > 5
    }
}
