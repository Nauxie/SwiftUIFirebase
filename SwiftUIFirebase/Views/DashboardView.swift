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
    
    @State private var userName: String? = nil
    
    @State private var editNum: Int = 0
    
    
    
    func onLogOut() {
        
        let logInSuccess = session.logOut()
        if (!logInSuccess) {
            self.error = "Log out failed"
        }
        
    }
    
    func saveNumber(num: Int) {
        let db = Firestore.firestore()
        let numRef = db.collection("users").document(session.sessionUID ?? "")
        numRef.updateData([
            "number": num
        ]) {
            err in
            if let err = err {
                self.error = err.localizedDescription
            }
        }
    }
    
    func fetchUser() {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(session.sessionUID ?? "invaliduser")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.userName = document.data()?["name"] as? String
                self.editNum = document.data()?["number"] as? Int ?? 0
            }
            else {
                self.error = error?.localizedDescription
            }
        }
    }
    
    var body: some View {
        VStack(spacing:30) {
            if userName == nil {
                ProgressView()
            }
            else {
                Text("Welcome")
                Text(self.userName ?? "")
                    .font(.headline)
            }
            HStack(spacing:10) {
                Button(action: {
                    self.editNum = self.editNum - 1
                    saveNumber(num: self.editNum)
                    
                }) {
                    Text("-")
                        .font(.headline)
                        .frame(width:20,height:20)
                        .foregroundColor(.black)
                        .overlay(
                            Circle()
                                .stroke(Color.black,lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        )
                }
                
                Text(String(editNum))
                Button(action: {
                    self.editNum = self.editNum + 1
                    saveNumber(num: self.editNum)
                    
                }) {
                    Text("+")
                        .font(.headline)
                        .frame(width:20,height:20)
                        .foregroundColor(.black)
                        .overlay(
                            Circle()
                                .stroke(Color.black,lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        )
                }
            }
            Button(action: onLogOut) {
                Text("Log Out")
                    .font(.headline)
                    .frame(width: 180, height: 50)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                    .background(Color(red:0,green:0,blue:0))
            }
        }.onAppear(perform: fetchUser)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
