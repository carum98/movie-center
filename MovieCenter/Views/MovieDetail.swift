//
//  MovieDetail.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

struct MovieDetail: View {
    let movie : Movies
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                Text(movie.overview)
            }.navigationBarTitle(movie.original_title)
        }

    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: Movies(id: 1, original_title: "Cruella", overview: "\"Cruella\" se sumerge en la juventud rebelde de uno de los villanos más conocidos -y más de moda-, nada menos que la legendaria Cruella de Vil. Emma Stone encarna a Estella, alias Cruella, junto a Emma Thompson como la Baronesa, la directora de una prestigiosa firma de moda que convierte a Estella en una incipiente diseñadora. La cinta está ambientada en el contexto del punk-rock londinense de los 70.  ( https://stream4k.xyz/en/movie/337404/cruella )"))
    }
}
