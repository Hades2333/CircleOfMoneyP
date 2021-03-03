//
//  MyDataSavings.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 3.03.21.
//

import UIKit

class DataModelSavings {

    // MARK:- Data Saving
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func accountsFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Accounts.plist")
    }

    func saveAccounts() {
        let encoder = PropertyListEncoder()
        do {

            let data = try encoder.encode(myAccounts)
            try data.write(to: accountsFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }

    func loadAccounts() {
        let path = accountsFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                myAccounts = try decoder.decode([Accounts].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }

    func categoriesFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Categories.plist")
    }

    func saveCategories() {
        let encoder = PropertyListEncoder()
        do {

            let data = try encoder.encode(myCategories)
            try data.write(to: categoriesFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }

    func loadCategories() {
        let path = categoriesFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                myCategories = try decoder.decode([Categories].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }

    func operationsFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Operations.plist")
    }

    func saveOperations() {
        let encoder = PropertyListEncoder()
        do {

            let data = try encoder.encode(myOperations)
            try data.write(to: operationsFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }

    func loadOperations() {
        let path = operationsFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                myOperations = try decoder.decode([Operations].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }

    func saveAll() {
        saveAccounts()
        saveCategories()
        saveOperations()
    }

    func loadAll() {
        loadAccounts()
        loadCategories()
        loadOperations()
    }
}
