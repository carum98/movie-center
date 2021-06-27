//
//  CastList.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 26/6/21.
//

import SwiftUI

struct ListCast: View {
    let cast : [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Reparto")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(cast ) { item in
                        NavigationLink(
                            destination: CastDetail(viewModel: CastViewModel(cast: item)),
                            label: {
                                VStack(alignment: .leading) {
                                    if let image = item.profilePath {
                                        Image(uiImage: "https://image.tmdb.org/t/p/w200\(image)".load())
                                            .resizable()
                                            .frame(width: 150, height: 250, alignment: .center)
                                            .cornerRadius(20)
                                    }

                                    Text("\(item.name)")
                                        .font(.title3)
                                    Text("\(item.character)")
                                        .font(.subheadline)
                                }
                                .frame(maxWidth: 150)
                                .padding(.vertical, 20)
                            }
                        ).buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}
