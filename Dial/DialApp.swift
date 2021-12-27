//
//  DialApp.swift
//  Dial
//
//  Created by Jesse Vincent on 12/26/21.
//

import SwiftUI


@main
struct DialApp: App {
    let persistenceController = PersistenceController.shared
    let notificationCenter = NSWorkspace.shared.notificationCenter
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)        .onReceive(notificationCenter.publisher(for: NSWorkspace.didActivateApplicationNotification)) {_ in
                    
                    print("Moving to the background!")
                  
                    let frontmostApp = NSWorkspace.shared.frontmostApplication!
                    print(frontmostApp)
                    
                    if(!persistenceController.appExistsInCoreData(bundleId: frontmostApp.bundleIdentifier ?? "com.example.unknown")) {
                    
                    let newItem = DialAppConfig(context: persistenceController.container.viewContext)
                        newItem.bundleId = frontmostApp.bundleIdentifier ?? "org.example.nobundle"
                        newItem.localizedAppName = frontmostApp.localizedName ?? "Unnamed app"
                    newItem.id = UUID()
                    
                    newItem.timestamp = Date()
                    do {
                        try persistenceController.container.viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    
                    }
                    }
                }


        }
            .onChange(of: scenePhase) { _ in
                print("SAving changes?")
                persistenceController.save()
            }
    }
    static func turnLeft() {

        print("nbow turning left")
        let src = CGEventSource(stateID: .privateState)

        let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: true)
        let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: false)
        let zd = CGEvent(keyboardEventSource: src, virtualKey: 0x06, keyDown: true)
        let zu = CGEvent(keyboardEventSource: src, virtualKey: 0x06, keyDown: false)

        let tabd = CGEvent(keyboardEventSource: src, virtualKey: 0x30, keyDown: true)
        let tabu = CGEvent(keyboardEventSource: src, virtualKey: 0x30, keyDown: false)

        zd?.flags = CGEventFlags.maskCommand
        tabd?.flags = CGEventFlags.maskCommand

        let loc = CGEventTapLocation.cghidEventTap

        cmdd?.post(tap:loc)
        

        tabd?.post(tap:loc)
        tabu?.post(tap:loc)
        cmdu?.post(tap:loc)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        cmdd?.post(tap: loc)
        zd?.post(tap: loc)
        zu?.post(tap: loc)

        cmdu?.post(tap: loc)
        }
        
    }
}
