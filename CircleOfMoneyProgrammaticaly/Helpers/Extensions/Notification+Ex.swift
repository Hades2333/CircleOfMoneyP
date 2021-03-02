//
//  Notification+Ex.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import Foundation

extension Notification.Name {
    static let accountsDataWasUpdated = Notification.Name("userDataUpdateNotification")
    static let accountsAndCategoriesWasUpdated = Notification.Name("userDataWasUpdatedFromHome")
    
    static let operationsUpdate = Notification.Name("operationsUpdate")
}
