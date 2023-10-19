import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var loginVM : LoginViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            NavigationLink(destination: AccountView()){
                
                HStack {
                    Image(systemName: "person.fill")
                    Text("Cuenta")
                }
            }
            .font(.title)
            .foregroundColor(.white)
            Divider()
                .frame(width: 220, height: 2)
                .background(Color.white)
                .padding(.horizontal, 10)
            Spacer()
            
            NavigationLink(destination: AppHome()){
                HStack {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
            }
            .font(.title)
            .foregroundColor(.white)
            //NavigationLink(destination: NotificationsView()){
            //
            //    HStack {
            //        Image(systemName: "bell.fill")
            //        Text("Notificaciones")
            //    }
            //}
            //.font(.title)
            //.foregroundColor(.white)
            
            NavigationLink(destination: incidentsView()){
                HStack {
                    Image(systemName: "plus.circle")
                    Text("Nuevo Ticket")
                }
            }
            .font(.title)
            .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                loginVM.signout()
            }) {
                HStack {
                    Image(systemName: "arrow.right.square")
                    Text("Logout")
                }
                .font(.title)
                .foregroundColor(.white)
                
            }
            
            Spacer()
        }
        .padding(32)
        .background(Color(hex: 0xE2032C))
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
