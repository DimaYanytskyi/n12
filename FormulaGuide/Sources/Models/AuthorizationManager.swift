
import Foundation
import FirebaseCore
import FirebaseAuth
import SwiftUI

@MainActor
class AuthMain: ObservableObject {
    @Published var text: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentuser: User?
    @Published var isNewUser = false
    @Published var hasCompletedOnboarding = false
    @Published var selectedAvatarIndex: Int = 0
    
    private let userDefaults = UserDefaults.standard
    private let avatarKey = "selectedAvatarIndex"
    private let onboardingKey = "hasCompletedOnboarding"
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.selectedAvatarIndex = userDefaults.integer(forKey: avatarKey)
        
        if let user = self.userSession {
            let userName = userDefaults.string(forKey: "userName_\(user.uid)") ?? "User"
            self.currentuser = User(id: user.uid, name: userName, email: user.email ?? "")
            
            self.hasCompletedOnboarding = userDefaults.bool(forKey: "\(onboardingKey)_\(user.uid)")
        } else {
            print("")
        }
    }
    
    func saveSelectedAvatar(_ index: Int) {
        selectedAvatarIndex = index
        userDefaults.set(index, forKey: avatarKey)
    }
    
    func getSelectedAvatarName() -> String {
        let avatars = ["icon1", "icon2", "icon3", "icon4", "icon5", "icon6"]
        return avatars[selectedAvatarIndex]
    }
    
    func signInAnonymously() async {
        do {
            let result = try await Auth.auth().signInAnonymously()
            isNewUser = true
            self.userSession = result.user
            
            self.currentuser = User(id: result.user.uid, name: "Guest", email: "")
            
            self.hasCompletedOnboarding = userDefaults.bool(forKey: "\(onboardingKey)_\(result.user.uid)")
        } catch {
            text = "Error: \(error.localizedDescription)"
        }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
            let userName = userDefaults.string(forKey: "userName_\(result.user.uid)") ?? "User"
            self.currentuser = User(id: result.user.uid, name: userName, email: email)
            
            self.hasCompletedOnboarding = userDefaults.bool(forKey: "\(onboardingKey)_\(result.user.uid)")
        } catch {
            text = "Error: \(error.localizedDescription)"
        }
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            isNewUser = true
            self.userSession = result.user
            
            self.currentuser = User(id: result.user.uid, name: name, email: email)
            
            userDefaults.set(name, forKey: "userName_\(result.user.uid)")
            
            self.hasCompletedOnboarding = false
        } catch {
            text = "Error: \(error.localizedDescription)"
        }
    }
    
    func deleteUserAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "UserErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in."])))
            return
        }
        
        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.userSession = nil
                self.currentuser = nil
                self.hasCompletedOnboarding = false
                self.isNewUser = false
                completion(.success(()))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentuser = nil
            self.hasCompletedOnboarding = false
            self.isNewUser = false
        } catch {
            text = "Error: \(error.localizedDescription)"
        }
    }
    
    func completeOnboarding() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            return 
        }
        
        userDefaults.set(true, forKey: "\(onboardingKey)_\(uid)")
        self.hasCompletedOnboarding = true
    }
    
    func updateUserName(_ newName: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return 
        }
        
        if let currentUser = self.currentuser {
            self.currentuser = User(id: currentUser.id, name: newName, email: currentUser.email)
        }
        
        userDefaults.set(newName, forKey: "userName_\(uid)")
    }
}

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
}
