//
//  AppList Row.swift
//  Dial
//
//  Created by Jesse Vincent on 12/26/21.
//

import SwiftUI
import CoreData


struct AppList_Row: View {
    @ObservedObject var appConfig: DialAppConfig

    var body: some View {
        HStack {
            Text(appConfig.localizedAppName)
         Text(appConfig.bundleId)
        }
            

    //    .onDelete(perform: deleteItems)

    }
}

