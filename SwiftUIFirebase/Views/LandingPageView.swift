//
//  LandingPageView.swift
//  SwiftUIFirebase
//
//  Created by Abhinav  Tumu on 7/22/20.
//

import SwiftUI

struct LandingPageView: View {
    
    
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                NavigationLink(destination: LogInView()) {
                    Text("Log In")
                        .font(.headline)
                        .frame(width: 180, height: 50)
                        .cornerRadius(10.0)
                        .foregroundColor(.white)
                        .background(Color(red:0,green:0,blue:0))
                }
                NavigationLink(destination:SignUpView()) {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(width: 180, height: 50)
                        .cornerRadius(10.0)
                        .foregroundColor(.black)
                        .background(Color(red:1,green:1,blue:1))
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                }
                
            }
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
