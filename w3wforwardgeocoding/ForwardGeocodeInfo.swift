//
//  ForwardGeocodeInfo.swift
//  w3wforwardgeocoding
//
//  Created by Niko Arellano on 2017-10-06.
//  Copyright © 2017 Mobilux. All rights reserved.
//

import Foundation

struct ForwardGeocodeInfo : Codable {
    struct Crs : Codable {
        struct Properties : Codable {
            let href : String
            let type : String
        }
        let type : String
        let properties : Properties
    }
    
    
    struct Bounds : Codable {
        struct Southwest : Codable {
            let lng : Double
            let lat : Double
        }
        
        struct Northeast : Codable {
            let lng : Double
            let lat : Double
        }
        
        let southwest : Southwest
        let northeast : Northeast
    }
    
    struct Geometry : Codable {
        let lng : Double
        let lat : Double
    }
    
    struct Status : Codable {
        let status : Int
        let reason : String
    }
    
    let crs : Crs
    let words : String
    let bounds : Bounds
    let geometry : Geometry
    let language : String
    let map : String
    let status : Status
    let thanks : String
    
}
