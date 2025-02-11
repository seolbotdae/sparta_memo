//
//  UserDefaultsManager.swift
//  sparta_memo
//
//  Created by Seol WooHyeok on 2/11/25.
//

import Foundation

class UserDefaultsManager<T> where T: Codable {
    private let defaults = UserDefaults.standard
    
    func saveData(key: String, value: [T]) {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(value) {
            defaults.set(data, forKey: key)
        }
    }
    
    func getData(key: String) -> [T]? {
        guard let data = defaults.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([T].self, from: data)
    }
}
