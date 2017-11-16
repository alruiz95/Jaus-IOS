//
//  JSON.swift
//  ProyectoJaus
//
//  Created by Alberto on 11/10/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation

class JSON {
    
    static func pasrseContra(_ data: Data) -> String{
        
        var responce : String = ""
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            print(json)
            
            let mainArray = json as! Array<AnyObject>
            
            responce = mainArray[0]["password"] as! String
            
        } catch {
            print ("Error")
        }
        
        return responce
    }
    
    static func pasrsePhoneNumber(_ data: Data) -> String{
        
        var responce : String = ""
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            print(json)
            
            let mainArray = json as! Array<AnyObject>
            
            let stri = mainArray[0]["phoneNumber"] as? String
            if( stri != nil){
                responce = stri!
            }
            
            
        } catch {
            print ("Error")
        }
        
        return responce
    }
    
    
    
    static func parseHouses(_ data: Data) -> [House]{
        
        var lugarList = [House]()
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            let mainArray = json as! Array<AnyObject>
            
            for casa in mainArray{
                let houseID = casa["houseID"] as! Int
                let houseProv = casa["Provider_username"] as! String
                let houseName = casa["name"] as! String
                let houseAdress = casa["address"] as! String
                let houseDetails = casa["details"] as! String
                let housePrice = casa["price"] as! Int
                let houseNego = casa["isNegotiable"] as! Bool
                let houseType = casa["houseType"] as! String
                let houseLat = casa["latitude"] as! Double
                let houseLon = casa["longitude"] as! Double
                
                
                
                let hogar = House(houseID: houseID, provUsername: houseProv, name: houseName, address: houseAdress, details: houseDetails, price: housePrice, isNegotiable: houseNego, type: houseType, lat: houseLat, lon: houseLon)
                lugarList.append(hogar)
            }
            
        } catch {
            print ("Error")
        }
        
        return lugarList
    }
    
    
    static func parseUpUser(_ data: Data) -> [String]{
        
        var responce : [String] = []
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            print(json)
            
            let mainArray = json as! Array<AnyObject>
            
            responce.append( mainArray[0]["password"] as! String)
            
            let name = mainArray[0]["name"] as? String
            if name == nil{
                responce.append("null")
            }else{
                responce.append(name!)
            }
            
            let lastname = mainArray[0]["lastName"] as? String
            if name == nil{
                responce.append("null")
            }else{
                responce.append(lastname!)
            }
            
            let phoneNumber = mainArray[0]["phoneNumber"] as? String
            if name == nil{
                responce.append("null")
            }else{
                responce.append(phoneNumber!)
            }
            
            let email = mainArray[0]["email"] as? String
            if name == nil{
                responce.append("null")
            }else{
                responce.append(email!)
            }
            
            let photo = mainArray[0]["photo"] as? String
            if name == nil{
                responce.append("null")
            }else{
                responce.append(photo!)
            }
            
            
        } catch {
            print ("Error")
        }
        
        return responce
    }
    
    static func parseServices(_ data: Data) -> [String]{
        
        var responce : [String] = []
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            print(json)
            
            let mainArray = json as! Array<AnyObject>
            
            for name in mainArray {
                let service = name["name"] as? String
                if service != nil{
                    responce.append(service!)
                }
            }
            
            
        } catch {
            print ("Error")
        }
        
        return responce
    }
    
    
}
