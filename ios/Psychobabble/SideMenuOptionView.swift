//
//  SIdeMenuOptionView.swift
//  Psychobabble
//
//  Created by Ian Chen on 5/18/22.
//

import SwiftUI

struct SideMenuOptionView: View {
    let viewModel: SideMenuViewModel
    var body: some View {
        HStack(spacing:16){
            Text(viewModel.title)
                .font(.system(size: 15, weight:.semibold))
            Spacer()
        }
        .padding(.bottom,16)
        .padding(.leading,16)
        .foregroundColor(.black)
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(viewModel: .category1)
    }
}
