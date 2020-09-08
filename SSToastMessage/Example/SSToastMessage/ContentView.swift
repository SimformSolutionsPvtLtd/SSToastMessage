//
//  ContentView.swift
//  SSToastMessage
//
//  Created by Ankit Panchal on 08/09/20.
//  Copyright © 2020 Simform Solution Pvt. Ltd. All rights reserved.
//

import SwiftUI
import SSToastMessage

struct MyButtonView : View {

    @Binding var showing: Bool
    var title: String
    var hideAll: ()->()

    var body: some View {
        Button(action: {
            self.hideAll()
            self.showing.toggle()
        }) {
            Text(title)
                .foregroundColor(.black)
        }
    }
}

struct ContentView: View {
    let bgColor = Color(hex: "D8F2F0")
    let popupColor = Color(hex: "3d5a80")
    let topToastColor = Color(hex: "293241")
    let bottomToastColor = Color(hex: "98c1d9")
    let topFloatColor = Color(hex: "BF5841")
    let bottomFloatColor = Color(hex: "ee6c4d")

    @State var showAlert = false
    @State var showTopToast = false
    @State var showBottomToast = false
    @State var showTopFloater = false
    @State var showBottomFloater = false

    func dismissAll() {
        self.showAlert = false
        self.showTopToast = false
        self.showBottomToast = false
        self.showTopFloater = false
        self.showBottomFloater = false
    }

    var body: some View {
                VStack {
                    VStack(spacing: 30) {
                        MyButtonView(showing: self.$showAlert, title: "Alert", hideAll: self.dismissAll)
                        MyButtonView(showing: self.$showTopToast, title: "Top Toast", hideAll: self.dismissAll)
                        MyButtonView(showing: self.$showBottomToast, title: "Bottom Toast", hideAll: self.dismissAll)
                        MyButtonView(showing: self.$showTopFloater, title: "Top Floater", hideAll: self.dismissAll)
                        MyButtonView(showing: self.$showBottomFloater, title: "Bottom Floater", hideAll: self.dismissAll)
                    }
                    .present(isPresented: self.$showAlert, type: .alert, autohideDuration: nil, closeOnTap: false) {
                        self.createAlertView()
                    }

                    .present(isPresented: self.$showTopToast, type: .toast, position: .top, onTap: {print("on toast tap")}) {
                        self.createTopToastView()
                    }
                    .present(isPresented: self.$showBottomToast, type: .toast, position: .bottom, onTap: {print("on toast tap")}) {
                        self.createBottomToastView()
                    }
                    .present(isPresented: self.$showTopFloater, type: .floater(), position: .top, animation: Animation.spring(), onTap: {print("on toast tap")}) {
                        self.createTopFloaterView()
                    }
                    .present(isPresented: self.$showBottomFloater, type: .floater(), position: .bottom,animation: Animation.spring(), autohideDuration: nil, onTap: {print("on toast tap")}) {
                        self.createBottomFloaterView()
                    }

            }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(bgColor)


    }

    func createAlertView() -> some View {
        VStack(spacing: 10) {
            Image("corona")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(width: 100, height: 100)

            Text("Hey There!!!")
                .foregroundColor(.white)
                .fontWeight(.bold)

            Text("Please click on dismiss to hide.")
                .font(.system(size: 12))
                .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))

            Spacer()

            Button(action: {
                self.showAlert = false
            }) {
                Text("Dismiss")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            .frame(width: 100, height: 40)
            .background(Color.white)
            .cornerRadius(20.0)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 20))
        .frame(width: 300, height: 300)
        .background(self.popupColor)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }

    func createTopToastView() -> some View {
        VStack {
            Spacer(minLength: 20)
            HStack() {
                Image("mike")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)

                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Mike")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Text("10:10")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                    }

                    Text("Hey, Don't miss the WWDC on tonight at 10 AM PST.")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }.padding(15)
        }
        .frame(width: UIScreen.main.bounds.width, height: 110)
        .background(self.topToastColor)
    }

    func createBottomToastView() -> some View {
        VStack {
            HStack() {
                Image("pizza")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Whooohoo!!")
                        .foregroundColor(.black)
                        .fontWeight(.bold)

                    Text("Your order has been placed succesfully! Sit sight we deliver the food in 20 minutes.")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
            }
            Spacer(minLength: 10)
        }
        .padding(15)
        .frame(width: UIScreen.main.bounds.width, height: 100)
        .background(self.bottomToastColor)
    }

    func createTopFloaterView() -> some View {
        VStack {
            HStack() {
                Image("mike")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)

                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Mike")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Text("10:10")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                    }

                    Text("Hey, Don't miss the WWDC on tonight at 10 AM PST.")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }.padding(15)
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 110)
        .background(self.topFloatColor)
        .cornerRadius(15)
    }

    func createBottomFloaterView() -> some View {
        HStack(spacing: 15) {
            Image("travel")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .frame(width: 60, height: 60)
                .cornerRadius(10.0)

            VStack(alignment: .leading, spacing: 2) {
                Text("Ever thought of taking a break from work and travel?")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .lineLimit(3)

                Text("If you have ever thought of something like a career break or sabbatical, you need to realize that there will never be a perfect time.")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
        }
        .padding(15)
        .frame(width: 350, height: 160)
        .background(self.bottomFloatColor)
        .cornerRadius(20.0)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}


