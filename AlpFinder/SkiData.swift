//
//  SkiData.swift
//  AlpFinder
//
//  Created by M. De Vries on 16/03/2024.
//

import Foundation


struct SkiData: Codable, Hashable{
    let resorts: [ResortData]
    
}

struct ResortData: Codable, Hashable{
    let name: String
    let webcams: [CamData]
    let website: URL
    let logo: URL
    let lift: LiftData
    
}

struct CamData: Codable, Hashable{
    let name: String
    let url: URL
}

struct LiftData: Codable, Hashable{
    let snowReport: URL
    let skiMap: URL
}


var Encoder: JSONEncoder{
    let enc = JSONEncoder()
    enc.keyEncodingStrategy = .useDefaultKeys
    return enc
}

var Decoder: JSONDecoder{
    let dec = JSONDecoder()
    dec.keyDecodingStrategy = .useDefaultKeys
    return dec
}
