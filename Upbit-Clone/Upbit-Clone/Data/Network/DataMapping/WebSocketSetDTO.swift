//
//  WebSocketSetDTO.swift
//  Upbit-Clone
//
//  Created by 김민창 on 2022/04/23.
//

import Foundation

struct WebSocketSetDTO: Codable {
    let type: MarketPriceTpye           //수신할 시세 타입
    let codes: [String]                 //수신할 시세 종목 정보
    let isOnlySnapshot: Bool?           //시세 스냅샷만 제공
    let isOnlyRealtime: Bool?           //실시간 시세만 제공
    
    enum MarketPriceTpye: String, Codable {
        case ticker = "ticker"          //현재가
        case trade = "trade"            //체결
        case orderbook = "orderbook"    //호가
    }
    
    init(
        type: MarketPriceTpye,
        codes: [String],
        isOnlySnapshot: Bool? = nil,
        isOnlyRealtime: Bool? = nil
    ) {
        self.type = type
        self.codes = codes
        self.isOnlySnapshot = isOnlySnapshot
        self.isOnlyRealtime = isOnlyRealtime
    }
}
