//
//  Service.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/11/21.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func getListNews(completion: @escaping(Result<[ObjetData], Error>) -> ()) {
        
        guard let url = URL(string: "http://3.238.21.227:8080/news/") else {
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
            data, response, error in
            
            
            //Nos aseguramos que no exista algún error de lo contrario retornar.
            if let error = error {
                print("Error: ", error)
                return
            }
            
            //Si se pudo almacenar la informacion la guardamos, en caso contrario retornar
            guard let data = data else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            //Ahora decodificar los Datos, sabemos que vienen en un formato Json así que podemos usar el decodificador  JSONDecoder
            
            do {
                let decodedData = try JSONDecoder().decode([ObjetData].self, from: data)
                completion(.success(decodedData))
            }
            catch {
                //Muestro mensaje de error en caso de un error de decodificacion
                print("Error en la descarga. ", error)
                completion(.failure(error))
            }
            
        })
        
        urlSession.resume()
    }
    
    
    func getDetailNews(id:String,completion: @escaping(Result<NewsDetail, Error>) -> ()) {
        
        guard let url = URL(string: "http://3.238.21.227:8080/news/\(id)") else {
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
            data, response, error in
            
            
            //Nos aseguramos que no exista algún error de lo contrario retornar.
            if let error = error {
                print("Error: ", error)
                return
            }
            
            //Si se pudo almacenar la informacion la guardamos, en caso contrario retornar
            guard let data = data else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            //Ahora decodificar los Datos, sabemos que vienen en un formato Json así que podemos usar el decodificador  JSONDecoder
            
            do {
                let decodedData = try JSONDecoder().decode(NewsDetail.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                //Muestro mensaje de error en caso de un error de decodificacion
                print("Error en la descarga. ", error)
                completion(.failure(error))
            }
            
        })
        
        urlSession.resume()
    }
    
    
    func getClients(completion: @escaping(Result<[Client], Error>) -> ()) {
        
        guard let url = URL(string: "http://3.238.21.227:8080/clients/?page=1") else {
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
            data, response, error in
            
            
            //Nos aseguramos que no exista algún error de lo contrario retornar.
            if let error = error {
                print("Error: ", error)
                return
            }
            
            //Si se pudo almacenar la informacion la guardamos, en caso contrario retornar
            guard let data = data else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            //Ahora decodificar los Datos, sabemos que vienen en un formato Json así que podemos usar el decodificador  JSONDecoder
            
            do {
                let decodedData = try JSONDecoder().decode([Client].self, from: data)
                completion(.success(decodedData))
            }
            catch {
                //Muestro mensaje de error en caso de un error de decodificacion
                print("Error en la descarga. ", error)
                completion(.failure(error))
            }
            
        })
        
        urlSession.resume()
    }
    
    
    func getProjectsById(id:String,completion: @escaping(Result<[Projects], Error>) -> ()) {
        
        guard let url = URL(string: "http://3.238.21.227:8080/clients/\(id)/projects/") else {
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
            data, response, error in
            
            
            //Nos aseguramos que no exista algún error de lo contrario retornar.
            if let error = error {
                print("Error: ", error)
                return
            }
            
            //Si se pudo almacenar la informacion la guardamos, en caso contrario retornar
            guard let data = data else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            //Ahora decodificar los Datos, sabemos que vienen en un formato Json así que podemos usar el decodificador  JSONDecoder
            
            do {
                let decodedData = try JSONDecoder().decode([Projects].self, from: data)
                completion(.success(decodedData))
            }
            catch {
                //Muestro mensaje de error en caso de un error de decodificacion
                print("Error en la descarga. ", error)
                completion(.failure(error))
            }
            
        })
        
        urlSession.resume()
    }
    
    
    func getActivitiesList(completion: @escaping(Result<[ActivityHour], Error>) -> ()) {
        
        guard let url = URL(string: "http://3.238.21.227:8080/activities") else {
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
            data, response, error in
            
            //Nos aseguramos que no exista algún error de lo contrario retornar.
            if let error = error {
                print("Error: ", error)
                return
            }
            
            //Si se pudo almacenar la informacion la guardamos, en caso contrario retornar
            guard let data = data else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            //Ahora decodificar los Datos, sabemos que vienen en un formato Json así que podemos usar el decodificador  JSONDecoder
            
            do {
                let decodedData = try JSONDecoder().decode([ActivityHour].self, from: data)
                completion(.success(decodedData))
            }
            catch {
                //Muestro mensaje de error en caso de un error de decodificacion
                print("Error en la descarga. ", error)
                completion(.failure(error))
            }
        })
        
        urlSession.resume()
    }
    
    func createActivityRecord (projectId:String, activity:[ActivitiesRecord], date:String, completion: @escaping(Result<[ResponseRecord],Error>) -> ()) {
        guard let url = URL(string: "http://3.238.21.227:8080/activity-records") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let newRecord = Record(idProject: projectId, activities: activity, date: date)
        guard let newActivityJson = try? JSONEncoder().encode(newRecord) else {
            return
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = newActivityJson
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            data, res, err in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                do {
                    
                    let decodedData = try JSONDecoder().decode([ResponseRecord].self, from: data)
                    completion(.success(decodedData))
                }
                catch {
                    //Muestro mensaje de error en caso de un error de decodificacion
                    print("Error en la descarga. ", error)
                    completion(.failure(error))
                }
            }
        }).resume()
    }
    
    func getDaysSinceLastRecord(completion: @escaping(Result<[ResponseRecord], Error>) -> ()) {
        
        guard let url = URL(string: "http://3.238.21.227:8080/activity-records") else {
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
            data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if let days = httpResponse.allHeaderFields["Days-Since-Last-Record"]{
                    if let daysString = days as? String, let daysRecord = Int(daysString){
                        GlobalParameters.shared.daysSinceLastRecord = daysRecord
                        print(daysRecord)
                    }
                }
            }
            
            //Nos aseguramos que no exista algún error de lo contrario retornar.
            if let error = error {
                print("Error: ", error)
                return
            }
            
            //Si se pudo almacenar la informacion la guardamos, en caso contrario retornar
            guard let data = data else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            //Ahora decodificar los Datos, sabemos que vienen en un formato Json así que podemos usar el decodificador  JSONDecoder
            
            do {
                let decodedData = try JSONDecoder().decode([ResponseRecord].self, from: data)
                completion(.success(decodedData))
            }
            catch {
                //Muestro mensaje de error en caso de un error de decodificacion
                print("Error en la descarga. ", error)
                completion(.failure(error))
            }
        })
        
        urlSession.resume()
    }
    
    
    func getActivityRecordList(completion: @escaping(Result<[ResponseRecord], Error>) -> ()) {
        
        guard let url = URL(string: "http://3.238.21.227:8080/activity-records/") else {
            return
        }
        
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler:{
            data, response, error in
            
            //Nos aseguramos que no exista algún error de lo contrario retornar.
            if let error = error {
                print("Error: ", error)
                return
            }
            
            //Si se pudo almacenar la informacion la guardamos, en caso contrario retornar
            guard let data = data else {
                return
            }
            
            //Ahora decodificar los Datos, sabemos que vienen en un formato Json así que podemos usar el decodificador  JSONDecoder
            
            do {
                let decodedData = try JSONDecoder().decode([ResponseRecord].self, from: data)
                completion(.success(decodedData))
            }
            catch {
                //Muestro mensaje de error en caso de un error de decodificacion
                print("Error en la descarga. ", error)
                completion(.failure(error))
            }
        })
        
        urlSession.resume()
    }
}



