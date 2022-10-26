//
//  PlayerInfo.swift
//  BaseballPlayerApp
//
//  Created by kuani on 2022/9/30.
//

import Foundation

struct PlayerInfo:Codable{
    let name:String
    let number:String
    let defense:String
    let team:String
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func loadPlayers() -> [PlayerInfo]?{
        /*
        let userDefault = UserDefaults.standard
        guard let data = userDefault.data(forKey: "players") else { return nil }
         */
        let decoder = JSONDecoder()
        let url = documentsDirectory.appendingPathComponent("player")
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? decoder.decode([PlayerInfo].self, from: data)
    }
    
    
    static func savePlayers(_ players:[PlayerInfo]){
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(players) else { return }
        /*
        let userDefault = UserDefaults.standard
        userDefault.set(data,forKey: "players")
        */
        let url = documentsDirectory.appendingPathComponent("player")
        try? data .write(to: url)
    }
    
}
