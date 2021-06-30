//
//  Loading.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.8)
                .cornerRadius(30)
                .blur(radius: 6)
            
            ProgressView().scaleEffect(4, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue)
            )
        }

    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
            .preferredColorScheme(.dark)
    }
}
