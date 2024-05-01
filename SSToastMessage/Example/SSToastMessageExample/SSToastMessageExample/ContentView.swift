//
//  ContentView.swift
//  SSToastMessageExample
//
//  Created by Yagnik Bavishi on 01/05/24.
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
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(.black)
        }
    }
}

struct ContentView: View {
    let bgColor = Color(hex: "E8F2F0")
    let alertColor = Color(hex: "ee6c4d")
    let topToastColor = Color(hex: "4067CC")
    let bottomToastColor = Color(hex: "bfdcae")
    let topFloatColor = Color(hex: "61A117")
    let bottomFloatColor = Color(hex: "3d5a80")
    let leftRightToastColor = Color(hex: "85adad")

    @State var showAlert = false
    @State var showTopToast = false
    @State var showBottomToast = false
    @State var showTopFloater = false
    @State var showBottomFloater = false
    @State var showDemoView = false
    @State var showLeftToastView = false
    @State var showRightToastView = false

    func dismissAll() {
        self.showAlert = false
        self.showTopToast = false
        self.showBottomToast = false
        self.showTopFloater = false
        self.showBottomFloater = false
        self.showLeftToastView = false
        self.showRightToastView = false
    }

    var body: some View {
        
        if #available(iOS 16.0, *, macOS 13.0) {
            NavigationStack {
                content
                    .navigationDestination(isPresented: $showDemoView, destination: {
                        DemoView()
                    })
            }
        } else {
            NavigationView {
                content
            }
        }
    }
    
    private var content: some View {
        GeometryReader { geometryProxy in
            VStack {
                VStack(spacing: 30) {
                    MyButtonView(showing: self.$showAlert, title: "Alert", hideAll: self.dismissAll)
                    MyButtonView(showing: self.$showTopToast, title: "Top Toast", hideAll: self.dismissAll)
                    MyButtonView(showing: self.$showBottomToast, title: "Bottom Toast", hideAll: self.dismissAll)
                    MyButtonView(showing: self.$showTopFloater, title: "Top Floater", hideAll: self.dismissAll)
                    MyButtonView(showing: self.$showBottomFloater, title: "Bottom Floater", hideAll: self.dismissAll)
                    MyButtonView(showing: self.$showLeftToastView, title: "Left Toast", hideAll: self.dismissAll)
                    MyButtonView(showing: self.$showRightToastView, title: "Right Toast", hideAll: self.dismissAll)
                }
                

                .present(isPresented: self.$showAlert, type: .alert, animation: Animation.interactiveSpring(), duration: nil, closeOnTap: false) {
                    self.createAlertView()
                }
                    
                .present(isPresented: self.$showTopToast, type: .toast, position: .top, duration: 6.0, onTap: {
                    showDemoView = true
                }, onToastDismiss: {
                    print("on toast hide")
                }) {
                    self.createTopToastView()
                }
                .present(isPresented: self.$showBottomToast, type: .toast, position: .bottom, onTap: {
                    showDemoView = true
                }) {
                    self.createBottomToastView()
                }
                .present(isPresented: self.$showTopFloater, type: .floater(), position: .top, animation: Animation.spring(), horizontalPadding: 60, onTap: {
                    showDemoView = true
                }) {
                    self.createTopFloaterView()
                }
                .present(isPresented: self.$showBottomFloater, type: .floater(), position: .bottom,animation: Animation.spring(), duration: 3, onTap: {
                    showDemoView = true
                }) {
                    self.createBottomFloaterView()
                }
                .present(isPresented: $showLeftToastView, type: .leftToastView, position: .bottom, duration: 3, onTap: {
                    showDemoView = true
                }) {
                    self.createLeftToastView()
                }
                           
                .present(isPresented: $showRightToastView, type: .rightToastView, position: .top, duration: 3, onTap: {
                    showDemoView = true
                }) {
                    self.createRightToastView()
                }
                
            }
            NavigationLink(destination: DemoView(), isActive: $showDemoView) {
                EmptyView()
            }
            .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
        }
        .ignoresSafeArea()
        .navigationViewStyle(.automatic)
        .background(self.bgColor)
        .buttonStyle(.plain)
        .ignoresSafeArea()
    }

    func createAlertView() -> some View {
        VStack(spacing: 10) {
            Image("corona")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(width: 100, height: 100)

            Text("Hey There!!!")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.bold)

            Text("Please click on dismiss to hide.")
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(.white)

            Spacer()

            Button(action: {
                self.showAlert = false
            }) {
                Text("Dismiss")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            .frame(width: 100, height: 40)
            .background(Color.white)
            .cornerRadius(20.0)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 20))
        .frame(width: 300, height: 300)
        .background(self.alertColor)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }

    func createTopToastView() -> some View {
        VStack {
            Spacer(minLength: 30)
            HStack() {
                Image("mike")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)

                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Mike")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Text("10:10")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }

                    Text("Great things never come from comfort zones.")
                        .lineLimit(2)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                }
            }.padding(15)
        }
        .frame(height: 130)
        .background(self.topToastColor)
    }

    func createBottomToastView() -> some View {
        VStack {
            HStack(alignment: .center) {
                Image("pizza")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Whooohoo!!")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "206a5d"))
                        .fontWeight(.bold)

                    Text("Your order has been placed succesfully! Sit tight we deliver the food in 20 minutes.")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "206a5d"))
                }
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: 100)
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
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Text("10:10")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    
                    Text("Hey, Welcome to Simform Solutions")
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        
                }
            }.padding(15)
        }
        .frame(height: 110)
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
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .lineLimit(3)

                Text("If you have ever thought of something like a career break or sabbatical, you need to realize that there will never be a perfect time.")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
        }
        .padding(15)
        .frame(width: 350, height: 160)
        .background(self.bottomFloatColor)
        .cornerRadius(20.0)
    }
    
    func createLeftToastView() -> some View {
        HStack {
            Text("Left Toast View!!")
                .lineLimit(2)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .font(.title)
            Image("leftToastImage")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .frame(width: 60, height: 60)
                .cornerRadius(10.0)
        }
        .frame(width: 200, height: 90)
        .background(self.leftRightToastColor)
        .cornerRadius(15)
    }
    
    func createRightToastView() -> some View {
        HStack {
            Image("rightToastImage")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .frame(width: 60, height: 60)
                .cornerRadius(10.0)
            Text("Right Toast View!!")
                .lineLimit(2)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .font(.title)
        }
        .frame(width: 200, height: 90)
        .background(self.leftRightToastColor)
        .cornerRadius(15)
    }

}

#Preview {
    ContentView()
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
