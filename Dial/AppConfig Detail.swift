//
//  AppConfig Detail.swift
//  Dial
//
//  Created by Jesse Vincent on 12/26/21.
//

import SwiftUI
import KeyboardShortcuts

struct AppConfig_Detail: View {
    @State var bar: String = "false"
    @ObservedObject var appConfig: DialAppConfig
    
    var body: some View {
        Form {
            Text(appConfig.localizedAppName)
            HStack {
                TextField("Left", text: $appConfig.turnLeftAction)
                
                
                
            }
            
            HStack {
                TextField ("Right",text: $appConfig.turnRightAction )
            }
            
            HStack { Button("Delete", action: doDelete)
                Button("Save", action: doSave)
            }
            Button("Left", action: turnLeft)
        }
        
        
        
    }
    func turnLeft() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            DialApp.turnLeft()
            //call any function
        }
    }
    
    
    
    func doDelete() {
        PersistenceController.shared.container.viewContext.delete(appConfig)
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
}
func doSave() {
    PersistenceController.shared.save()
}
