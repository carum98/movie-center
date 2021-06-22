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
                NavigationLink(
                    destination: MoviesList(),
                    label: {
                        Text("Peliculas")
                    })
                NavigationLink(
                    destination: TVShowList(),
                    label: {
                        Text("Series")
                    })
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
