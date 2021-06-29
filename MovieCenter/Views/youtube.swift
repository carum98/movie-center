//
//  youtube.swift
//  MovieCenter
//
//  Created by Usuario on 29/6/21.
//

import SwiftUI
import youtube_ios_player_helper
struct youtube: UIViewRepresentable {
        var videoID : String
         func makeUIView(context: Context) -> YTPlayerView {
             let playerView = YTPlayerView()
            playerView.load(withVideoId: videoID, playerVars: ["playsinline":1])
             return playerView
         }
         func updateUIView(_ uiView: YTPlayerView, context: Context) {
             //
         }
  
}


//
//  Videos.swift
//  MovieCenter
//
//  Created by Usuario on 29/6/21.
//

//import SwiftUI
//import youtube_ios_player_help
//struct Videos: View {
//    var body: some View {
//        var videoID : String
//
//        func makeUIView(context: Context) -> YTPlayerView {
//            let playerView = YTPlayerView()
//            playerView.load(withVideoId: videoID)
//            return playerView
//        }
//
//        func updateUIView(_ uiView: YTPlayerView, context: Context) {
//            //
//        }
//    }
//}
//struct YTWrapper : UIViewRepresentable {
//    var videoID : String
//
//    func makeUIView(context: Context) -> YTPlayerView {
//        let playerView = YTPlayerView()
//        playerView.load(withVideoId: videoID)
//        return playerView
//    }
//
//    func updateUIView(_ uiView: YTPlayerView, context: Context) {
//        //
//    }
//}

