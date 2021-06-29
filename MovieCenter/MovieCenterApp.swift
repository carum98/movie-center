//
//  MovieCenterApp.swift
//  MovieCenter
//
//  Created by Carlos Eduardo Umaña Acevedo on 17/6/21.
//

import SwiftUI

@main
struct MovieCenterApp: App {
    let persistenceController = PersistanceController.shared
        
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.colorScheme, .dark)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
                    switch newScenePhase{
                    case .background:
                        print("Scene backgroun")
                        persistenceController.guardar()
                    case .inactive:
                        print("Scene inactive")
                    case .active:
                        print("Scene active")
                    @unknown default:
                        print("Something change")
                    }
        }
    }
}
