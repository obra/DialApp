import SwiftUI
import Preferences
import LaunchAtLogin


struct GeneralSettingsView: View {
    // @AppStorage("colorSelecction") var colorSelecction = 0
    // @AppStorage("autoCloseWindowEditor") var autoCloseWindowEditor = false
    // @AppStorage("autoCloseWindowTimer") var autoCloseWindowTimer = 0
    // @AppStorage("notesSizeInGrid") var notesSizeInGrid = 0.0
    
    @ObservedObject private var launchAtLogin = LaunchAtLogin.observable
    
    private let contentWidth: Double = 450.0
    
    var body: some View {
        Preferences.Container(contentWidth: contentWidth) {
            
            Preferences.Section(label: {
                Toggle("Launch at login", isOn: $launchAtLogin.isEnabled)
            }) {
                
                Text("When checked, the app will automatically start when you log in.")
                    .preferenceDescription()
            }
            
        }
    }
}


extension Preferences.PaneIdentifier {
    static let general = Self("general")
}
