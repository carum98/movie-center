//
//  TVShowsDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowsDetail: View {
    @EnvironmentObject var viewModel : TVShowViewModel
    let tvShow : TVShow
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                HStack(alignment: .bottom, spacing: 20) {
                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(tvShow.posterPath)".load())
                        .resizable()
                        .frame(width: 100, height: 150, alignment: .center)
                        .cornerRadius(30)
                        
                        VStack {
                            HStack {
                                Spacer()
                                HStack {
                                    ForEach(0..<Int(tvShow.voteAverage)) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                            Spacer()
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text(tvShow.originalName)
                                    Text(tvShow.firstAirDate)
                                }
                                Spacer()
                                Image(systemName: "star.fill")
                                    .padding(20)
                            }
                        }
                        

                    }.padding(20)
                    Text(tvShow.overview)
                    Spacer()
                    Text("Recomendaciones")
                        .font(.title)
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.recomendations) { item in
                                NavigationLink(
                                    destination: TVShowsDetail(tvShow: item) ,
                                    label: {
                                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(item.posterPath)".load())
                                            .resizable()
                                            .frame(width: 150, height: 250, alignment: .center)
                                            .cornerRadius(20)
                                    })

                            }
                        }
                    }
            }
            .navigationBarTitle(tvShow.originalName, displayMode: .inline)
        }
        
        .onAppear() {
            viewModel.fetchRecomendation(tvId: tvShow.id)
        }
        .onDisappear() {
            viewModel.recomendations.removeAll()
        }
    }
}

struct TVShowsDetail_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsDetail(tvShow: TVShow(id: 1, originalName: "Loki", overview: "Loki, el impredecible villano Loki (Hiddleston) regresa como el Dios del engaño en una nueva serie tras los acontecimientos de Avengers", backdropPath: "/ykElAtsOBoArgI1A8ATVH0MNve0.jpg", posterPath: "/kAHPDqUUciuObEoCgYtHttt6L2Q.jpg", firstAirDate: "2021-02-13", voteAverage: 3))
            .preferredColorScheme(.dark)
            .environmentObject(TVShowViewModel())
    }
}
