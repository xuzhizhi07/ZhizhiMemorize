//
//  ContentView.swift
//  ZhiMemorize
//
//  Created by 抱谷 on 2025/2/24.
//

import SwiftUI

struct ContentView: View {
    
//    let emojis: Array<String> = ["👾","👻","🎃","🤡"]
    let emojis: [String] = ["👾","👻","🎃","🤡","🥹","🤖"]
    
    @State var cardCount: Int = 4
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        
        .padding(20)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 174, maximum: 300))]) {
            ForEach(0..<cardCount, id:\.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action:{
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    

    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
  
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "s")
    }
    
    var cardCountAdjusters: some View {
        HStack(spacing: 100) {
            cardRemover
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
}
 
struct CardView: View {
    
    let content: String
    
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack() {
            let base:RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
            
        }
        .onTapGesture() {
//            isFaceUp.toggle()
            isFaceUp = !isFaceUp
        }
    }
}


/*
 “type” ： a struct type (ContentView)
 protocol oriented programming: 面向协议的编程
 this struct, called contenview, behaves like a view
 
 object oriented programming VS functional programming
 前者是基础是data and encapsulation（数据封装）
 后者的基础是behavior，只需要设置variable，会有很多fuction需要做
 
 
 --------
 computed proterty 计算属性
 
 creating intances of structs 创建结构的实例
    eg：image struct、 text struct
 named parameters  命名的参数
    eg: systemName
 paremaeter defalut 参数默认值
 
 --------
 tuple view
 a funtion
 @ViewBulider 视图构建器（ a list of views turn into a tuple view
 
 
 -----------
 view modifer 视图修饰符
 
 -----------
 all structs,every var has a value 所有的变量都有一个值
 -----------
 trailing closure syntax
 -----------
 implict return 一行代码，接受可隐藏的return
 */

#Preview {
    ContentView()
}
