//
//  OrderbookDTO.swift
//  Upbit-Clone
//
//  Created by 김민창 on 2022/04/23.
//

import Foundation

struct OrderbookGetDTO: Codable {
    let type: String                 //타입
    let code: String                 //마켓 코드 (ex. KRW-BTC)
    let totalAskSize: Double         //호가 매도 총 잔량
    let totalBidSize: Double         //호가 매수 총 잔량
    let orderbookUnits: [Double]     //호가
    let askPrice: Double             //매도 호가
    let bidPrice: Double             //매수 호가
    let askSize: Double              //매도 잔량
    let bidSize: Double              //매수 잔량
    let timestamp: Int8              //타입스탬프(milliseccond)
    
    enum CodingKeys: String, CodingKey {
        case type, code, timestamp
        case totalAskSize = "total_ask_size"
        case totalBidSize = "total_bid_size"
        case orderbookUnits = "orderbook_units"
        case askPrice = "ask_price"
        case bidPrice = "bidPrice"
        case askSize = "ask_size"
        case bidSize = "bid_size"
    }
}
