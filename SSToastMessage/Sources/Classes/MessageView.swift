//
//  MessageView.swift
//  SSToastMessage
//
//  Created by Ankit Panchal on 08/09/20.
//  Copyright © 2020 Simform Solution Pvt. Ltd. All rights reserved.
//

import SwiftUI

public struct MessageView<MessageContent>: ViewModifier where MessageContent: View {
    
   @ObservedObject var viewModel = ViewModel()
    
    public enum MessageType {
        
        case alert
        case toast
        case floater(verticalPadding: CGFloat = 50)
        
        func shouldBeCentered() -> Bool {
            switch self {
                case .alert:
                    return true
                default:
                    return false
            }
        }
    }
    
    public enum Position {
        
        case top
        case bottom
    }
    
    // MARK: - Public Properties
    
    /// Tells if the sheet should be presented or not
    @Binding var isPresented: Bool
    
    var type: MessageType
    var position: Position
    
    var animation: Animation
    
    /// If nil - don't dismiss automatically
    var duration: Double?
    
    /// Should Add horizontal padding - default - 0
    var horizontalPadding: CGFloat?
    
    /// Should close on tap - default is `true`
    var closeOnTap: Bool
    
    /// Allow to perform action on tap default is
    var onTap: () -> Void
    
    /// Allow to perform any action when toast dismiss
    var onToastDismiss: () -> Void
    
    /// Should close on tap outside - default is `false`
    var closeOnTapOutside: Bool
    
    var view: () -> MessageContent
        
    @State private var viewHeight: CGFloat = .zero
    @State private var viewWidth: CGFloat = .zero

    /// holder for autohiding dispatch work (to be able to cancel it when needed)
    var dispatchWorkHolder = DispatchWorkHolder()
    
    // MARK: - Private Properties
    
    /// The rect of the hosting controller
    @State private var presenterContentRect: CGRect = .zero
    
    /// The rect of popup content
    @State private var sheetContentRect: CGRect = .zero
    
    /// The offset when the popup is displayed
    private var displayedOffset: CGFloat {
        switch type {
        case .alert:
            return  -presenterContentRect.midY + viewHeight/2
        case .toast:
            if position == .bottom {
                return viewHeight - presenterContentRect.midY - sheetContentRect.height/2
            } else {
                return -presenterContentRect.midY + sheetContentRect.height/2
            }
        case .floater(let verticalPadding):
            if position == .bottom {
                return viewHeight - presenterContentRect.midY - sheetContentRect.height/2 - verticalPadding
            } else {
                return -presenterContentRect.midY + sheetContentRect.height/2 + verticalPadding
            }
        }
    }
    
    /// The offset when the popup is hidden
    private var hiddenOffset: CGFloat {
        if position == .top {
            if presenterContentRect.isEmpty {
                return -1000
            }
            return -presenterContentRect.midY - sheetContentRect.height/2 - 5
        } else {
            if presenterContentRect.isEmpty {
                return 1000
            }
            return screenHeight - presenterContentRect.midY + sheetContentRect.height/2 + 5
        }
    }
    
    /// The current offset, based on the **presented** property
    private var currentOffset: CGFloat {
        return isPresented ? displayedOffset : hiddenOffset
    }
    
    private var screenHeight: CGFloat {
        #if os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size.height
        #elseif os(macOS)
        return NSScreen.main?.frame.height ?? 0
        #elseif os(iOS)
        return UIScreen.main.bounds.size.height
        #endif
    }
    
    private var screenWidth: CGFloat {
        #if os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size.width
        #elseif os(macOS)
        return  NSScreen.main?.frame.width ?? 0
        #elseif os(iOS)
        return UIScreen.main.bounds.size.width
        #endif
    }
    
    // MARK: - Content Builders
    
    public func body(content: Content) -> some View {
        GeometryReader { proxy in
            ZStack {
                content
                    .background(
                        GeometryReader { proxy -> AnyView in
                            let rect = proxy.frame(in: .global)
                            // This avoids an infinite layout loop
                            if rect.integral != self.presenterContentRect.integral {
                                DispatchQueue.main.async {
                                    viewModel.updateView = true
                                    self.presenterContentRect = rect
                                }
                            }
                            return AnyView(EmptyView())
                        }
                    )
                    .overlay(presentSheet())
                #if !(os(macOS))
                    .navigationBarHidden(true)
                #endif
                if closeOnTapOutside {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.isPresented = false
                        }
                        .opacity(isPresented ? 0.5 : 0)
                }
            }.onReceive(viewModel.$updateView, perform: { _ in
                viewHeight = proxy.size.height
                #if os(macOS) || targetEnvironment(macCatalyst)
                viewWidth = proxy.size.width - (horizontalPadding ?? 0)
                #elseif os(iOS)
                viewWidth = screenWidth - (horizontalPadding ?? 0)
                #endif
            })
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    /// This is the builder for the sheet content
    func presentSheet() -> some View {
        
        // if needed, dispatch autoDismiss and cancel previous one
        if let duration = duration {
            dispatchWorkHolder.work?.cancel()
            dispatchWorkHolder.work = DispatchWorkItem(block: {
                self.isPresented = false
                self.onToastDismiss()
            })
            if isPresented, let work = dispatchWorkHolder.work {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: work)
            }
        }
        
        return ZStack {
            Group {
                VStack {
                    VStack {
                        self.view()
                            .simultaneousGesture(TapGesture().onEnded {
                                if self.closeOnTap {
                                    self.isPresented = false
                                    self.onTap()
                                }
                            })
                            .background(
                                GeometryReader { proxy -> AnyView in
                                    let rect = proxy.frame(in: .global)
                                    // This avoids an infinite layout loop
                                    if rect.integral != self.sheetContentRect.integral {
                                        DispatchQueue.main.async {
                                            self.sheetContentRect = rect
                                        }
                                    }
                                    return AnyView(EmptyView())
                                }
                        )
                    }
                }
                .frame(width: viewWidth)
                .offset(x: 0, y: currentOffset)
                .animation(animation, value: isPresented)
            }
        }
    }
}

