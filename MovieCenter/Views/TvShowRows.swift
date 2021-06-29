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
          return (serie.generes.contains(genero) && serie.backdropPath != nil && serie.posterPath != nil)
        }
        return series
    }
    var body: some View {
        ScrollView(.vertical){
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
                                        destination: TVShowsDetail(tvShow: serie, favorito: false),
                                        label: {
                                            LazyVStack(spacing: 1) {
                                                Image(uiImage: "https://image.tmdb.org/t/p/w185\(serie.posterPath ?? "")".load())
                                                    .resizable()
                                                    .frame(width: 100, height: 150, alignment: .center)
                                                    .cornerRadius(30)
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
}
