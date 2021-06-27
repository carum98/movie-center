//
//  Loading.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        ProgressView().scaleEffect(5, anchor: .center)
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
