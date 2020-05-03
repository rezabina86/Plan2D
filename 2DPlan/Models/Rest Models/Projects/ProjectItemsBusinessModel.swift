//
//  ProjectsBusinessModel.swift
//  Plan2D
//
//  Created by Reza Bina on 2020-04-27.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation
import UIKit

struct ProjectItemsBusinessModel {
    
    struct Fetch {
        
        struct Request {
            let hash: String
        }
        
        struct Response: Decodable, Hashable {
            let items: [ProjectBusinessModel]
            
            static func == (lhs: ProjectItemsBusinessModel.Fetch.Response, rhs: ProjectItemsBusinessModel.Fetch.Response) -> Bool {
                lhs.items.first?.hash == rhs.items.first?.hash
            }
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(items.first?.hash)
            }
        }
        
    }
    
}

extension ProjectItemsBusinessModel.Fetch.Response {
    
    var size: CGSize {
        let width = items.first?.data.width ?? 0
        let height = items.first?.data.height ?? 0
        return CGSize(width: width, height: height)
    }
    
    var floor: ProjectBusinessModel.ProjectItem? {
        return items.first?.data.items.first(where: { $0.className == "Floor" })
    }
    
    func draw(completion: @escaping (_: UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            UIGraphicsBeginImageContext(self.size)
            guard var context = UIGraphicsGetCurrentContext() else { return }
            self.floor?.rooms.forEach({ room in
                self.drawWalls(context: &context, room: room)
                self.fillRoom(context: &context, room: room)
            })
            completion(UIGraphicsGetImageFromCurrentImageContext())
            UIGraphicsEndImageContext()
        }
    }
    
    private func drawWalls(context: inout CGContext, room: ProjectBusinessModel.FloorItem) {
        room.walls.forEach { wall in
            let points = wall.wallPoints.map({ CGPoint(x: CGFloat($0.x) + room.startPoint.x, y: CGFloat($0.y) + room.startPoint.y) })
            context.move(to: points[0])
            context.addLine(to: points[1])
            context.setLineCap(.round)
            context.setLineWidth(CGFloat(wall.w))
            context.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            context.strokePath()
        }
    }
    
    private func fillRoom(context: inout CGContext, room: ProjectBusinessModel.FloorItem) {
        var roomsWallPoints: [CGPoint] = []
        room.walls.forEach({
            let point = $0.wallPoints.map({ CGPoint(x: CGFloat($0.x) + room.startPoint.x, y: CGFloat($0.y) + room.startPoint.y) })
            roomsWallPoints.append(contentsOf: point)
        })
        let path = CGMutablePath()
        path.addLines(between: roomsWallPoints)
        context.addPath(path)
        UIColor.white.setFill()
        context.fillPath()
    }
    
}
