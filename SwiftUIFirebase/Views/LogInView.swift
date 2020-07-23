//
//  LogInView.swift
//  SwiftUIFirebase
//
//  Created by Abhinav  Tumu on 7/22/20.
//

import SwiftUI

struct LogInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var error: String? = nil
    
    @EnvironmentObject var session: SessionStore
    
    func onLogIn() {
        error = nil
        session.signIn(email: email, password: password ) { (result, error) in
            if error != nil {
                self.error = error?.localizedDescription
            }
            else {
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
            Button(action: onLogIn) {
                Text("Log In")
                    .font(.headline)
                    .frame(width: 180, height: 50)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                    .background(Color(red:0,green:0,blue:0))
            }
        }.padding()
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
