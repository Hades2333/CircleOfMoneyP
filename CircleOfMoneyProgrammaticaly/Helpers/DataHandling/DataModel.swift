//
//  DataModel.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import UIKit

struct DataModel {
    var accounts: [Accounts]
    var categories: [Categories]
    var operations: [Operations]
}

struct Accounts: Codable {
    var image: Image
    var nameOfAccount: String
    var amountOfMoney: Double
    var currency: Currency

    init(image: Image, nameOfAccount: String,
         amountOfMoney: Double, currency: Currency) {
        self.image = image
        self.nameOfAccount = nameOfAccount
        self.amountOfMoney = amountOfMoney
        self.currency = currency
    }
}

struct Image: Codable {
    let imageData: Data?

    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }

    func getImage(with tintColor: UIColor = UIColor(named: "greenGreatTint")!) -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)

        return image?.withTintColor(tintColor)
    }
}

struct Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0

    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

var myAccounts: [Accounts] = [Accounts(image: Image(withImage: UIImage(named: "3")!),
                                       nameOfAccount: "Job",
                                       amountOfMoney: 43.9,
                                       currency: .USD),
                              Accounts(image: Image(withImage: UIImage(named: "4")!),
                                                                     nameOfAccount: "Renting",
                                                                     amountOfMoney: 391,
                                                                     currency: .PLN)]

struct Categories {
    var image: Image
    var nameOfAccount: String
    var amountOfMoney: Double
    var color: Color
    var currency: Currency

    init(image: Image,
         nameOfAccount: String,
         amountOfMoney: Double,
         color: Color,
         currency: Currency) {
        self.image = image
        self.nameOfAccount = nameOfAccount
        self.amountOfMoney = amountOfMoney
        self.color = color
        self.currency = currency
    }
}

var myCategories: [Categories] = [Categories(image: Image(withImage: UIImage(named: "17")!.withTintColor(UIColor(named: "Color9")!)),
                                             nameOfAccount: "Food",
                                             amountOfMoney: 60,
                                             color: Color(uiColor: UIColor(named: "Color9")!),
                                             currency: .USD)]

struct Operations {
    var category: Categories
    var account: Accounts
    var amountOfMoney: Double
    var currency: Currency
    var date: Date
}

var myOperations: [Operations] = [Operations(category: myCategories[0],
                                             account: myAccounts[0],
                                             amountOfMoney: 10.0,
                                             currency: .USD,
                                             date: Date())]

var iconsForAccounts: [String] = ["0", "1", "2", "3",
                                  "4", "5", "6", "7",
                                  "8", "9", "10", "11",
                                  "12", "13", "14", "15",
                                  "16", "17", "18", "19",
                                  "20", "21", "22", "23"]

var colorsForAccounts: [UIColor] = [UIColor(named: "Color0") ?? .black,
                                    UIColor(named: "Color1") ?? .black,
                                    UIColor(named: "Color2") ?? .black,
                                    UIColor(named: "Color3") ?? .black,
                                    UIColor(named: "Color4") ?? .black,
                                    UIColor(named: "Color5") ?? .black,
                                    UIColor(named: "Color6") ?? .black,
                                    UIColor(named: "Color7") ?? .black,
                                    UIColor(named: "Color8") ?? .black,
                                    UIColor(named: "Color9") ?? .black,
                                    UIColor(named: "Color10") ?? .black,
                                    UIColor(named: "Color11") ?? .black,
                                    UIColor(named: "Color12") ?? .black,
                                    UIColor(named: "Color13") ?? .black,
                                    UIColor(named: "Color14") ?? .black,
                                    UIColor(named: "Color15") ?? .black,
                                    UIColor(named: "Color16") ?? .black,
                                    UIColor(named: "Color17") ?? .black,
                                    UIColor(named: "Color18") ?? .black,
                                    UIColor(named: "Color19") ?? .black,
                                    UIColor(named: "Color20") ?? .black,
                                    UIColor(named: "Color21") ?? .black,
                                    UIColor(named: "Color22") ?? .black,
                                    UIColor(named: "Color23") ?? .black,]

enum Currency: String, Codable {
    case USD = "Dollars"
    case BYN = "Belorussian rubles"
    case RUB = "Russian rubles"
    case EUR = "Euro"
    case GBP = "Pound Sterling"
    case NOK = "Norwegian Krone"
    case PLN = "Polish Złoty"
    case UAH = "Ukrainian Hryvnia"
}

var currency: [String] = [Currency.USD.rawValue,
                          Currency.BYN.rawValue,
                          Currency.RUB.rawValue,
                          Currency.EUR.rawValue,
                          Currency.GBP.rawValue,
                          Currency.NOK.rawValue,
                          Currency.PLN.rawValue,
                          Currency.UAH.rawValue]

