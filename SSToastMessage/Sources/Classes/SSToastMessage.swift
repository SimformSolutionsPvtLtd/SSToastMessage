//
//  View+Extension.swift
//  SSToastMessage
//
//  Created by Ankit Panchal on 08/09/20.
//  Copyright © 2020 Simform Solution Pvt. Ltd. All rights reserved.
//

import SwiftUI

extension View {
    
    ///  Add this modifier to the top most  views in hierarchy.
    ///  Parameters:
    ///   - isPresented: binding to determine if the message view should be seen on-screen or hidden
    ///   - type: set type of view alert, toast and float.
    ///   - position: top or bottom (for default case it just determines animation direction).
    ///   - animation: custom animation for message view sliding onto screen.
    ///   - duration: time after which message view should disappear.
    ///   - closeOnTap: on message view tap it should disappear.
    ///   - onTap: on message view tap perform any action or navigation.
    ///   - onToastDismiss: on toast dismiss perform any action.
    ///   - closeOnTapOutside: on outside tap message view should disappear.
    ///   - view: view you want to display on your message view
    /// - Returns: void
    public func present<MessageContent: View>(
        isPresented: Binding<Bool>,
        type: MessageView<MessageContent>.MessageType = .alert,
        position: MessageView<MessageContent>.Position = .bottom,
        animation: Animation = Animation.easeOut(duration: 0.3),
        horizontalPadding: CGFloat? = 0,
        duration: Double? = 3.0,
        closeOnTap: Bool = true,
        closeOnTapOutside: Bool = false,
        onTap: (() -> Void)? = nil,
        onToastDismiss: (() -> Void)? = nil,
        view: @escaping () -> MessageContent) -> some View {
        self.modifier(
            MessageView(
                isPresented: isPresented,
                type: type,
                position: position,
                animation: animation,
                duration: duration, 
                horizontalPadding: horizontalPadding,
                closeOnTap: closeOnTap,
                onTap: onTap ?? {},
                onToastDismiss: onToastDismiss ?? {},
                closeOnTapOutside: closeOnTapOutside,
                view: view)
        )
    }
    
}
