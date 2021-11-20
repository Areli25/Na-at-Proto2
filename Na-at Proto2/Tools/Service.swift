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
        
        guard let url = URL(string: "http://3.238.21.227:8080/clients/") else {
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
}


