//
//  ContentView.swift
//  Psychobabble
//
//  Created by Ian Chen on 5/16/22.
//

import SwiftUI

struct ContentView : View {
    // For Carousel
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 100
    @State var op : CGFloat = 0
    
    @State var data = [

        Card(id: 0, text: "text", show: false),
        Card(id: 1, text: "text", show: false),
        Card(id: 2, text: "text", show: false),

    ]
    
    @State private var showMenu: Bool = false
    
    var body : some View{
        
        NavigationView{
            
            ZStack{
                Color(.white)
                // Carousel and App Title
                VStack{
                    // MARK: Title and subtitle
                    VStack(alignment: .center, spacing: 5) {
                                            Text("PSYCHOBABBEL")
                                                .font(.system(size: 35, weight: .semibold, design: .default))
                                            Text("A better way to communicate.")
                                        }
                                        .padding()
                    // MARK: Carousel
                    HStack(spacing: 50){
                        
                        ForEach(data){card in
                            
                            CardView(data: card)
                                .offset(x: self.x + CGFloat(card.id < Int(count) ? 100 : card.id > Int(count) ? -100 : 0))
                                .zIndex(card.id == Int(count) ? 1 : 0)
                            .highPriorityGesture(DragGesture()
                            
                                .onChanged({ (value) in
                                    
                                    if value.translation.width > 0{
                                        
                                        self.x = value.location.x
                                    }
                                    else{
                                        
                                        self.x = value.location.x - self.screen
                                    }
                                    
                                })
                                .onEnded({ (value) in

                                    if value.translation.width > 0{
                                        
                                        
                                        if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
                                            
                                            
                                            self.count -= 1
                                            self.updateHeight(value: Int(self.count))
                                            self.x = -((self.screen + 50) * self.count)
                                        }
                                        else{
                                            
                                            self.x = -((self.screen + 50) * self.count)
                                        }
                                    }
                                    else{
                                        
                                        
                                        if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.data.count - 1){
                                            
                                            self.count += 1
                                            self.updateHeight(value: Int(self.count))
                                            self.x = -((self.screen + 50) * self.count)
                                        }
                                        else{
                                            
                                            self.x = -((self.screen + 50) * self.count)
                                        }
                                    }
                                })
                            )
                        }
                    } //Hstack
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(x: self.op)
                    
                    
                    Spacer()
        
                } // Vstack
                
                
                .background(Color(red: 249, green: 246, blue: 246).edgesIgnoringSafeArea(.bottom))
//                .navigationTitle("PSYCHOBABBEL")
            
                .animation(.spring())
                .onAppear {
                    self.op = ((self.screen + 50) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 50) / 2) : 0)
                    self.data[0].show = true
                }
                
                
                GeometryReader { _ in
                          
                          HStack {
                            
                            SideMenuView()
                              .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width) // Making it a negative value will open the side menu from the left
                              .animation(.easeInOut(duration: 0.4), value: showMenu)
                              
                            
                          }
                          
                }
//                        .background(Color.black.opacity(showMenu ? 0.1 : 0))
                
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                      self.showMenu.toggle()
                    } label: {

                      if showMenu {

                        Image(systemName: "xmark")
                          .foregroundColor(.black)

                      } else {
                        Image(systemName: "text.justify")
                          .foregroundColor(.black)
                      }

                    }
                }
            } // ZStack
            // when you press back on the side menu, it
            // brings you back to the main carousel view
            .onAppear{
                showMenu = false
            }

            
            
        } // NavigationView
    } // View
    
    func updateHeight(value : Int){
        
        
        for i in 0..<data.count{
            
            data[i].show = false
        }
        
        data[value].show = true
    }
}
  
struct CardView: View {
    var data: Card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(data.text)
                .foregroundColor(Color.black)
        }
        .frame(width: UIScreen.main.bounds.width - 100, height: data.show ? UIScreen.main.bounds.width - 100 : UIScreen.main.bounds.width - 200)
        .background(Color.white)
        .border(.black)
    }
}

struct Card: Identifiable {
    var id: Int
    var text: String
    var show: Bool
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CarouselView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = RoomsViewController(collectionViewLayout: UPCarouselFlowLayout())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}
