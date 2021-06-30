//
//  MainMenu.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI
struct MainMenu: View {
    let array = ["bg1", "bg2", "bg3", "bg4"]
    @State var cargar:Bool = false
    var body: some View {        
        NavigationView {
            ZStack {
                Image(array.randomElement()!)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Rectangle().foregroundColor(.clear).background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)).scaledToFill()
                  
            }.onAppear(
                perform: {cargar = false}
            ).overlay(
                Group{
                    ZStack(alignment: .center){
                        if(cargar){
                            Loading()
                        }
                    }
                    Image("logo")
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                    NavigationLink(
                        destination: MoviesList().environmentObject(MoviesViewModel()),
                        label: {
                            CustomButton(label: "Peliculas", icon: "film")
                        }).onTapGesture {
                            cargar = true
                        }
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
        }
        .padding()
        .frame(minWidth: 0, maxWidth: 300)
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [.black, .red]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(40)
    }
}
