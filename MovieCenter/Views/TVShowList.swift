//
//  TVShowList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 21/6/21.
//

import SwiftUI

struct TVShowList: View {
    @ObservedObject var viewModel : TVShowViewModel = TVShowViewModel()
    
    var body: some View {
        List {
            ForEach(self.viewModel.tvShows, id: \.id) { item in
//                NavigationLink(
//                    destination: MovieDetail(movie: item) ,
//                    label: {
                        Text(item.originalName)
//                    })
            }
        }
        .navigationBarTitle("Lista de Series")
        .onAppear {
            viewModel.fetchTVShows()
        }
//        .overlay(Group {
//            if self.viewModel.movies.isEmpty {
//                Loading()
//            }
//        })
    }
}

struct TVShowList_Previews: PreviewProvider {
    static var previews: some View {
        TVShowList()
    }
}
