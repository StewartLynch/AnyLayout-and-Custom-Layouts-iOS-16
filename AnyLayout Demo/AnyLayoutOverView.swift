//
// Created for AnyLayout Demo
// by Stewart Lynch on 2022-10-10
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct MyColors {
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    static var allColors:[MyColors] {
        [
            .init(color: .red, width: 60, height: 75),
            .init(color: .teal, width: 100, height: 100),
            .init(color: .purple, width: 40, height: 80),
            .init(color: .indigo, width: 120, height: 100)
        ]
    }
}


struct AnyLayoutOverView: View {
    @State private var layoutType = LayoutType.zStack
    var body: some View {
        let layout = AnyLayout(layoutType.layout)
        NavigationStack {
            layout {
                ForEach(MyColors.allColors, id: \.color) { myColor in
                    myColor.color
                        .frame(width: myColor.width, height: myColor.height)
                }
            }
            .animation(.default, value: layoutType)
            .padding()
            .navigationTitle("AnyLayout")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if layoutType.index < LayoutType.allCases.count - 1 {
                            layoutType = LayoutType.allCases[layoutType.index + 1]
                        } else {
                            layoutType = LayoutType.allCases[0]
                        }
                    } label: {
                        Image(systemName: "circle.grid.3x3.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        AnyLayoutOverView()
    }
}

enum LayoutType: Int, CaseIterable {
    case zStack, hStack, vStack, altStack
    
    var index: Int {
        LayoutType.allCases.firstIndex(where: {$0 == self})!
    }
    
    var layout: any Layout {
        switch self {
        case .zStack:
            return ZStackLayout()
        case .hStack:
            return HStackLayout(alignment: .top, spacing: 0)
        case .vStack:
            return VStackLayout(alignment: .trailing)
        case .altStack:
            return AlternateStackLayout()
        }
    }
}
