//
//  Service.swift
//  Aqar First
//
//  Created by Ahmed Fathy on 18/10/2022.
//

import Foundation

enum Service: String, CaseIterable {
    case furniture
    case maintenance
    case contracts
    case financing
    case engineering
    case eval
    case dev
    case bids
    case kitchens
    
    var title: String {
        switch self {
        case .furniture: return "نقل وتركيب الأثاث"
        case .maintenance: return "خدمات الصيانة"
        case .contracts: return "توثيق العقود"
        case .financing: return "التمويل العقاري"
        case .engineering: return "الخدمات الهندسية والمقاولات"
        case .eval: return "التقييم العقاري"
        case .dev: return "التطوير العقاري"
        case .bids: return "المزايدات والمناقصات العقارية"
        case .kitchens: return "تفصيل المطابخ"
        }
    }
}
