//
//  ContentView.swift
//  Dial
//
//  Created by Jesse Vincent on 12/26/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DialAppConfig.localizedAppName, ascending: true)],
        animation: .default)
    private var appConfigs:  FetchedResults<DialAppConfig>

    
    
    
    var body: some View {
        NavigationView {
            List(appConfigs, id: \.id) { appConfig in
   
                NavigationLink {
                    AppConfig_Detail(appConfig: appConfig)
                }
            label: {
                AppList_Row(appConfig: appConfig)
                }
            }
            .navigationTitle(/*@START_MENU_TOKEN@*/"Title"/*@END_MENU_TOKEN@*/)

            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
          
            
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = DialAppConfig(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            do {
               
               try viewContext.save()
           } catch {
               // Replace this implementation with code to handle the error appropriately.
               // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               let nsError = error as NSError
               fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { appConfigs[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
