//
//  SideMenuView.swift
//  Psychobabble
//
//  Created by Ian Chen on 5/18/22.
//

import SwiftUI

struct SideMenuView: View {
  
  var body: some View {
      GeometryReader { geometry in
          ZStack{
              VStack {
                  Section(header: Text("")) {
                      EmptyView()

                  }
                  .padding(.bottom, geometry.size.height * 0.10)
   
                // MARK: - Menu items
                
                  ForEach(SideMenuViewModel.allCases, id: \.self){ option in
                      NavigationLink(
                        destination: Text(option.title),
                        label:{ SideMenuOptionView(viewModel: option)
                            
                        })
                  }
                  Spacer()
              
                

              }
              .padding(32)
              .background(Color.gray)
              .edgesIgnoringSafeArea(.all)
              
          }
          .frame(width: abs(geometry.size.width * 0.65), height: abs(UIScreen.main.bounds.height), alignment: .center)
          
      }
      
      
  }
  
}

struct SideMenuView_Previews: PreviewProvider {
  static var previews: some View {
    SideMenuView()
  }
}
