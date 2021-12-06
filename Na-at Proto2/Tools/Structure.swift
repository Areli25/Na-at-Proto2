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
    var duration: Int? = 0
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
}

struct ClientShow{
    var id: String
    var name: String
    var project: [ProjectShow]
}

struct ProjectShow{
    var id: String
    var name: String
    var activity: [Activity]
}

struct Activity:Encodable{
    var id:String?
    var name: String
    var duration: Int
}
struct ActivitiesRecord:Encodable{
    var id:String
    var duration:Int
}

struct Record:Encodable {
    var idProject:String
    var activities: [ActivitiesRecord]
    var date:String
}
struct ResponseRecord:Decodable {
    var project:Project
    var activityRecords:[ResponseActivity]
}
struct Project:Decodable{
    var name:String
    var client:Clients
}
struct Clients:Decodable {
    var name:String
}
struct NameActivity:Decodable {
    var name:String
}
struct ResponseActivity:Decodable {
    var activity:NameActivity
    var duration:Int
    var date:String
    var id:String
}
