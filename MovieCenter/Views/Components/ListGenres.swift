//
//  ListGenre.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 26/6/21.
//

import SwiftUI

struct ListGenres: View {
    let genres : [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres) { item in
                    Text(verbatim: item.name)
                      .padding(8)
                      .background(
                        RoundedRectangle(cornerRadius: 8)
                          .fill(Color.gray.opacity(0.2)))
                }
            }
        }
    }
}
