//
//  ProjectBusinessModel.swift
//  Plan2D
//
//  Created by Reza Bina on 2020-04-27.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

struct ProjectBusinessModel: Decodable {
    
    let udate: Date
    let name: String
    let s: String
    let hash: String
    let uid: String
    let data: ProjectData
    let gstatus: String
    let my: Bool
    let readOnly: Int
    
    struct ProjectData: Decodable {
        let className: String
        let version: Int
        let width: Int
        let height: Int
        let sscounter: Int
        let s: Int
        let currentFloor: Int
        let autoinc: Int
        let ground: ProjectGround
        let v: Int
        let items: [ProjectItem]
    }
    
    struct ProjectGround: Decodable {
        let texture: String
        let color: String
    }
    
    struct ProjectItem: Decodable {
        let className: String
        let name: String
        let puid: String
        let items: [FloorItem]
    }
    
    struct FloorItem: Decodable {
        let className: String
        let x: Float
        let y: Float
        let z: Float
        let sX: Float
        let sY: Float
        let puid: String
        let items: [RoomItem]?
    }
    
    struct RoomItem: Decodable {
        let className: String
        let hidden: Bool
        let w: Int
        let puid: String
        let items: [Item]
    }
    
    struct Item: Decodable {
        let className: String
        let x: Float
        let y: Float
        let puid: String
    }
    
}

extension ProjectBusinessModel.ProjectItem {
    
    var rooms: [ProjectBusinessModel.FloorItem] {
        return items.filter({ $0.className == "Room" })
    }
    
}

extension ProjectBusinessModel.FloorItem {
    
    var walls: [ProjectBusinessModel.RoomItem] {
        return items?.filter({ $0.className == "Wall" }) ?? []
    }
    
    var startPoint: CGPoint {
        return CGPoint(x: Int(x), y: Int(y))
    }
    
}

extension ProjectBusinessModel.RoomItem {
    
    var wallPoints: [ProjectBusinessModel.Item] {
        return items.filter({ $0.className == "Point" })
    }
    
}

extension ProjectBusinessModel.Item {
    
    var point: CGPoint {
        return CGPoint(x: Int(x), y: Int(y))
    }
    
}

