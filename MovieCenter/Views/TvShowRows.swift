import SwiftUI

struct TvShowRows: View {
   // var viewModel : TVShowViewModel
    @EnvironmentObject var viewModel : TVShowViewModel
    var laRegion:String
    var generos:[Genre]
    var series:[TVShow]
    var favoritos:Bool
    func ObtengaLasSeriesPorGenero(lasSeries:[TVShow], genero:Int) -> [TVShow]{
        let series:[TVShow] = lasSeries.filter{ serie in
          return (serie.generes.contains(genero))          
        }
        return series
    }
    var body: some View {
        LazyVStack(spacing: 20) {
            ForEach(generos, id: \.id){ genere in
                let lasSeries:[TVShow] = ObtengaLasSeriesPorGenero(lasSeries: series,genero: genere.id)
                if (lasSeries.count > 0){
                    VStack(alignment: .leading, spacing: 6) {
                    Text(genere.name).font(.title).frame(alignment: .leading)
                        ScrollView(.horizontal){
                            LazyHStack(spacing: 20) {
                                ForEach(lasSeries, id: \.id){ serie in
                                    NavigationLink(
                                        destination:  TVShowList()
                                            .environmentObject(TVShowViewModel()),
                                        label: {
                                            LazyVStack(spacing: 1) {
                                                Image(uiImage: "https://image.tmdb.org/t/p/w200\(serie.posterPath)".load())
                                                    .resizable()
                                                    .frame(width: 100, height: 150, alignment: .center)
                                            }
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
            }.overlay(Group {
                if self.series.isEmpty {
                    Loading()
                }
            })
        }
    }
}
