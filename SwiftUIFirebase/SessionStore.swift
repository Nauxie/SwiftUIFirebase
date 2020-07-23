//
//  SessionStore.swift
//  SwiftUIFirebase
//
//  Created by Abhinav  Tumu on 7/22/20.
//

//
//  SessionStore.swift
//  genie-swiftui
//
//  Created by Abhinav  Tumu on 7/20/20.
//

import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    @Published var sessionUID: String?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.sessionUID = user.uid
                
            } else {
                // if we don't have a user, set our session to nil
                self.sessionUID = nil
            }
        }
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func logOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.sessionUID = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // additional methods (sign up, sign in) will go here
}
