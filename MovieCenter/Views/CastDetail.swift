//
//  CastDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 26/6/21.
//
import SwiftUI

struct CastDetail: View {
    @ObservedObject var viewModel : CastViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                HStack(alignment: .bottom, spacing: 20) {
                    Image(uiImage: "https://image.tmdb.org/t/p/w200\(viewModel.cast.profilePath ?? "")".load())
                    .resizable()
                    .frame(width: 100, height: 150, alignment: .center)
                    .cornerRadius(30)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Actor")
                            .bold()
                        Text(viewModel.cast.detail?.birthday ?? "")
                            .bold()
                        Text(viewModel.cast.detail?.place_of_birth ?? "")
                            .bold()
                    }
                    
                    Spacer()
                }
            }.padding(20)
            .onAppear {
                viewModel.fetchCastDetail()
            }
            
            VStack(alignment: .leading) {
                Text("Biografia")
                    .font(.title)
                Text(viewModel.cast.detail?.biography ?? "Sin descripcion")
            }
        }
        .navigationBarTitle(viewModel.cast.name, displayMode: .inline)
    }
}
