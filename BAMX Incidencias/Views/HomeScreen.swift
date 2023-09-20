
import SwiftUI

struct ContentView: View {
    @State private var showMenu = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.showMenu.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 44))
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .overlay(
                VStack(alignment: .leading, spacing: 20) {
                    if showMenu {
                        NavigationLink(destination: Text("Inicio")) {
                            HStack {
                                Image(systemName: "house.fill")
                                Text("Inicio")
                            }
                        }
                        NavigationLink(destination: Text("Notificaciones")) {
                            HStack {
                                Image(systemName: "bell.fill")
                                Text("Notificaciones")
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .background(Color.red)
                .offset(y: showMenu ? 0 : -200)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

