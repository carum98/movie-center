//
//  MainMenu.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct MainMenu: View {
    let array = ["bg1", "bg2", "bg3", "bg4"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(array.randomElement()!)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Rectangle().foregroundColor(.clear).background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)).scaledToFill()
            }.overlay(
                Group{
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    NavigationLink(
                        destination: MoviesList(),
                        label: {
                            CustomButton(label: "Peliculas", icon: "film")
                        })

                    NavigationLink(
                        destination: TVShowList(),
                        label: {
                            CustomButton(label: "Series", icon: "tv")
                        })
                }
            )
        }
        .navigationBarHidden(true)
        .environmentObject(TVShowViewModel())
        .environmentObject(MoviesViewModel())
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}
struct CustomButton: View {
    let label : String
    let icon : String

    var body: some View {
        VStack {
            Text(label)
                .bold()
        }
        .font(.title)
        .frame(minWidth: 0, maxWidth: 300)
        .background(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.red.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
        .foregroundColor(.white)
        .padding()
        .cornerRadius(40)
    }
}
