//
//  DashboardView.swift
//  SwiftUIFirebase
//
//  Created by Abhinav  Tumu on 7/22/20.
//

import SwiftUI
import Firebase

struct DashboardView: View {
    
    @State private var error: String? = nil
    
    @EnvironmentObject var session: SessionStore
    
    func onLogOut() {
        
        let logInSuccess = session.logOut()
        if (!logInSuccess) {
            self.error = "Log out failed"
        }
        
    }
    
    func fetchUser() {
        let db = Firestore.firestore()
    }
    
    var body: some View {
        VStack {
            Button(action: onLogOut) {
                Text("Log Out")
                    .font(.headline)
                    .frame(width: 180, height: 50)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                    .background(Color(red:0,green:0,blue:0))
            }
            
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
