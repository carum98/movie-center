//
//  MainMenu.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(
                    destination: MoviesList(),
                    label: {
                        CustomButton(label: "Peliculas", icon: "film")
                    })
                Spacer()
                NavigationLink(
                    destination: TVShowList(),
                    label: {
                        CustomButton(label: "Series", icon: "tv")
                    })
                Spacer()
            }.navigationTitle("MovieCenter")
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
            .preferredColorScheme(.dark)
            
    }
}

struct CustomButton: View {
    let label : String
    let icon : String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(label)
                .bold()
        }
        .frame(width: 200.0)
        .font(.system(size: 40))
        .padding(40)
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(lineWidth: 2.0)
                .shadow(color: .blue, radius: 10.0)
    )
    }
}
