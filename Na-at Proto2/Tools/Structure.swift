//
//  Structure.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/11/21.
//

import Foundation

struct NewsData: Decodable{
    var objData:[ObjetData]
}
struct ObjetData:Decodable{
    var id: String
    var image: String
    var creationDate: String
    var headline: String
    var summary: String
    var body: String
}

struct NewsDetail:Decodable{
    var id: String
    var creationDate:String
    var enabled:Bool
    var headline: String
    var body: String
    var image:String
}

struct Client:Decodable{
    var id: String
    var name:String
}
struct Projects:Decodable{
    var id: String
    var name:String
}

struct ActivityHour:Decodable{
    var id: String
    var name:String
    var duration:Int? = 0
}
struct NotificationStructure{
    var title:String
    var date:String
    var body:String
    var priority:Int
}

//Struct ActivityHour

struct ActivityHourShow{
var client: ClientShow
var project: ProjectShow
var activity: [Activity]
}

struct ClientShow{
var id: String
var name: String
}

struct ProjectShow{
var id: String
var name: String
}

struct Activity{
var name: String
var duration: Int
}


