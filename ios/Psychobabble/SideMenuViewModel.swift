//
//  SideMenuViewModel.swift
//  Psychobabble
//
//  Created by Ian Chen on 5/18/22.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable{
    case quickGuide
    case category1
    case category2
    case category3
    case category4
    case category5
    case category6
    
    var title: String{
        switch self {
        case .quickGuide: return "Quick Guide"
        case .category1: return "Category 1"
        case .category2: return "Category 2"
        case .category3: return "Category 3"
        case .category4: return "Category 4"
        case .category5: return "Category 5"
        case .category6: return "Category 6"
        }
    }
    

}
