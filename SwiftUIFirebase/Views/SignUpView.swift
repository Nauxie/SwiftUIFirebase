//
//  SignUpView.swift
//  SwiftUIFirebase
//
//  Created by Abhinav  Tumu on 7/22/20.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var error: String? = nil
    
    @EnvironmentObject var session: SessionStore
    
    func onSignUp() {
        error = nil
        session.signUp(email: email, password: password ) { (result, error) in
            if error != nil {
                self.error = error?.localizedDescription
            }
            else {
                let db = Firestore.firestore()
                db.collection("users").document(result!.user.uid).setData(["name":name,"email":email,"uid":result!.user.uid]) { (error) in
                    if error != nil {
                        self.error = error?.localizedDescription ?? "An unknown error occurred"
                    }
                }
                self.name = ""
                self.email = ""
                self.password = ""
            }
            
        }
        
    }
    
    var body: some View {
        if error != nil {
            Text(error ?? "There was an issue, please try again.")
                .foregroundColor(.red)
        }
        VStack(spacing: 35) {
            TextField("Name", text: $name)
                .padding()
                .frame(width:320)
                .background(Color(red:0.97,green:0.97,blue:0.97))
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            TextField("Email", text: $email)
                .padding()
                .frame(width:320)
                .background(Color(red:0.97,green:0.97,blue:0.97))
                .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            SecureField("Password", text: $password)
                .padding()
                .frame(width:320)
                .background(Color(red:0.97,green:0.97,blue:0.97))
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            
            Button(action: onSignUp) {
                Text("Sign Up")
                    .font(.headline)
                    .frame(width: 180, height: 50)
                    .cornerRadius(10.0)
                    .foregroundColor(.black)
                    .background(Color(red:1,green:1,blue:1))
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            }
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
