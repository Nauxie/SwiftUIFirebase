//
//  StartingView.swift
//  SwiftUIFirebase
//
//  Created by Abhinav  Tumu on 7/22/20.
//

import SwiftUI

struct StartingView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.sessionUID != nil) {
                DashboardView()
            }
            else {
                LandingPageView()
            }
        }.onAppear(perform: getUser)
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
