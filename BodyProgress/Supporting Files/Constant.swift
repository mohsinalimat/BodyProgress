//
//  Constant.swift
//  BodyProgress
//
//  Created by Karthick Selvaraj on 25/04/20.
//  Copyright © 2020 Mallow Technologies Private Limited. All rights reserved.
//

import SwiftUI

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

let kShadowRadius: CGFloat = 3.0
let kCornerRadius: CGFloat = 15.0
let kDefaultValue = "-"
let kPrimaryTitleFont = Font.system(.title, design: .rounded)
let kPrimaryLargeTitleFont = Font.system(.largeTitle, design: .rounded)
let kPrimaryBodyFont = Font.system(.body, design: .rounded)
let kPrimaryHeadlineFont = Font.system(.headline, design: .rounded)
let kPrimarySubheadlineFont = Font.system(.subheadline, design: .rounded)
let kPrimaryColour = Color.green
let kPrimaryUIColour = UIColor.systemGreen
let kCommonListIndex = 9999
let kOneHour: Int16 = 3600
let kOneMinute: Int16 = 60

enum BodyParts: String, CaseIterable {
    case arms = "Arms"
    case chest = "Chest"
    case shoulders = "Shoulders"
    case abs = "Abs"
    case back = "Back"
    case legs = "Leg"
    case core = "Core"
    case fullBody = "Full Body"
    case cardio = "Cardio"
    case others = "Others"
    
    func color() -> Color {
        switch self {
        case .core, .cardio, .others: return Color(.systemGray2)
        case .arms: return Color(.systemRed)
        case .back: return Color(.systemGreen)
        case .chest: return Color(.systemBlue)
        case .legs: return Color(.systemPurple)
        case .shoulders: return Color(.systemYellow)
        case .abs: return Color(.systemOrange)
        case .fullBody: return Color(.systemPink)
        }
    }
}
