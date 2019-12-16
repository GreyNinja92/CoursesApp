//
//  Home.swift
//  Coursera
//
//  Created by Saksham Ram Khatod on 27/07/19.
//  Copyright © 2019 Saksham Ram Khatod. All rights reserved.
//

import SwiftUI

let statusBarHeight = UIApplication.shared.statusBarFrame.height
let screen = UIScreen.main.bounds

struct Home: View {
    @State var show = false
    @State var showProfile = false
    
    var body: some View {
        ZStack {
            
            HomeList()
                .blur(radius: show ? 20 : 0)
                .scaleEffect(showProfile ? 0.95 : 1)
                .animation(.default)
            
            ContentView()
                .frame(minWidth: 0, maxWidth: 712)
                .cornerRadius(30)
                .shadow(radius: 20)
                //                .rotation3DEffect(Angle(degrees: showProfile ? 0 : 90), axis: (x: UIScreen.main.bounds.width, y: -UIScreen.main.bounds.height, z: 0))
                .animation(.spring())
                .offset(x: showProfile ? 0 : UIScreen.main.bounds.width)
                .offset(y: showProfile ? statusBarHeight + 40 : UIScreen.main.bounds.height)
            
            MenuButton(show: $show)
                .offset(x: -UIScreen.main.bounds.width/2 + 5, y: /*showProfile ? UIScreen.main.bounds.height/2 + statusBarHeight :*/ -UIScreen.main.bounds.height/2 + 110)
                .animation(.spring())
            
            MenuRight(show: $showProfile)
                .offset(x: UIScreen.main.bounds.width/2 - 45, y: /*showProfile ? UIScreen.main.bounds.height/2 + statusBarHeight :*/ -UIScreen.main.bounds.height/2 + 110)
                .animation(.spring())
            
            MenuView(show: $show)
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
        }
    }
}
#endif

struct MenuRow: View {
    var image = "creditcard"
    var text = "My Account"
    var body: some View {
        HStack {
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(.secondary)
                .frame(width: 32, height: 32)
            Text(text)
                .foregroundColor(.primary)
                .font(.headline)
            Spacer()
        }
    }
}

struct Menu: Identifiable {
    var id = UUID()
    var title: String
    var icon: String
}

let menuData = [
    Menu(title: "My Account", icon: "person.crop.circle"),
    Menu(title: "Settings", icon: "gear"),
    Menu(title: "Billing", icon: "creditcard"),
    Menu(title: "Team", icon: "person.and.person"),
    Menu(title: "Sign out", icon: "arrow.uturn.down")
]

struct MenuView: View {
    var menu = menuData
    @Binding var show : Bool
    @State var showSettings: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                
                ForEach(menu) { item in
                    if item.title == "Settings" {
                        Button(action: { self.showSettings.toggle() }) {
                            MenuRow(image: item.icon, text: item.title)
                                .sheet(isPresented: self.$showSettings) { Settings() }
                        }
                    } else {
                        MenuRow(image: item.icon, text: item.title)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(30)
            .frame(minWidth: 0, maxWidth: 360)
            .background(Color("button"))
            .cornerRadius(30)
            .padding(.trailing, 60)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10, z: 0))
            .animation(.default)
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture {
                self.show.toggle()
            }
            Spacer()
        }
        .padding(.top, statusBarHeight)
        //            .tapAction {
        //                self.show.toggle()
        //        }
    }
}

struct CircleButton: View {
    var icon = "person.crop.circle"
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.primary)
        }
        .frame(width: 44, height: 44)
        .background(Color("button"))
        .cornerRadius(30)
        .shadow(color: Color("buttonShadow"), radius: 10, y: 10)
    }
}

struct MenuButton: View {
    @Binding var show : Bool
    var body: some View {
        ZStack(alignment: .topLeading) {
            Button(action: { self.show.toggle() }) {
                HStack {
                    Spacer()
                    Image(systemName: "list.dash")
                        .foregroundColor(.primary)
                }
                .padding(.trailing, 18)
                .frame(width: 90, height: 60)
                .background(Color("button"))
                .cornerRadius(30)
                .shadow(color: Color("buttonShadow"), radius: 10, y: 10)
            }
            Spacer()
        }
    }
}

struct MenuRight: View {
    @Binding var show : Bool
    @State var showUpdateList : Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Button(action: { self.show.toggle() }) {
                    CircleButton(icon: "person.crop.circle")
                }
                Button(action: { self.showUpdateList.toggle() }) {
                    CircleButton(icon: "bell")
                        .padding(.trailing)
                        .sheet(isPresented: self.$showUpdateList) { UpdateList() }
                }
            }
            Spacer()
        }
    }
}
