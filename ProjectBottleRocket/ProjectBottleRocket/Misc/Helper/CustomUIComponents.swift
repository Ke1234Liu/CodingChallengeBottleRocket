//
//  CustomUIComponents.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import Foundation
import UIKit

extension UIImage {
    static let tabLunch = UIImage(named: "tab_lunch")
    static let tabInternet = UIImage(named: "tab_internets")
    static let mapIcon = UIImage(named: "icon_map")
    static let closeIcon = UIImage(named: "ic_close")
    static let refreshIcon = UIImage(named: "ic_webRefresh")
    static let forwardIcon = UIImage(named: "ic_webForward")
    static let backIcon = UIImage(named: "ic_webBack")
}

extension UIFont {
    static func avenirBold(for fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir Next Demi Bold", size: fontSize)
    }
    
    static func avenirRegular(for fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir Next Regular", size: fontSize)
    }
}

extension UIColor {
    static let navBarGreen = UIColor(displayP3Red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
    static let restaurantGreen = UIColor(displayP3Red: 52/255, green: 179/255, blue: 121/255, alpha: 1.0)
    static let tabBarItemNotSelected = UIColor(displayP3Red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
    static let tabBarColor = UIColor(displayP3Red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
}
