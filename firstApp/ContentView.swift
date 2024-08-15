//
//  ContentView.swift
//  firstApp
//
//  Created by  Федор Попко on 08.08.2024.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis: [String] = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹",                         "😱","☠️","🍭"]
    // Happy New Year-themed emojis
    let happyNewYearEmojis: [String] = ["🎉", "🎊", "🥂", "🍾", "🎇", "🎆", "🥳", "🕺", "💃", "🎈", "🎁", "🍬"]
    // Angry New Year-themed emojis
    let angryNewYearEmojis: [String] = ["😠", "😡", "🤬", "😤", "💥", "🔥", "🥀", "💣", "🧨", "🙄", "😾", "😒"]
    // Neutral New Year-themed emojis
    let neutralNewYearEmojis: [String] = ["🕰️", "🛋️", "🥂", "🌙", "⏳", "📅", "🎇", "🧴", "🧊", "📦", "🚶‍♂️", "🔮"]
    
    @State var emojis: [String] = ["awd", "awd", "awd", "awd"]
    @State var currentTheme: Int = 1
    @State var isGray = [false, false, false]
    @State var cardCount: Int = 4
    @State var chooseTheme = false
    let themeNames = ["New Year", "Halloween", "Angry mode"]
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.title).fontWeight(.black)
            if !chooseTheme {
                Spacer()
                startText
            } else {
                ScrollView {
                    cards
                }
            }
            Spacer()
            buttons
        }
        .padding()
    }
    
    var startText: some View {
        Text("Please choose theme to start game!")
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .lineLimit(4)
            .padding([.top, .leading, .bottom])
        
    }
    
    var theme1: some View {
        createTheme(by: 0, emojisArr: happyNewYearEmojis, "tree.fill")
    }
    
    var theme2: some View {
        createTheme(by: 1, emojisArr: halloweenEmojis, "face.smiling.inverse")
    }
    
    var theme3: some View {
        createTheme(by: 2, emojisArr: angryNewYearEmojis, "person.bust.fill")
    }
    
    func createTheme(by numTheme: Int, emojisArr: [String], _ label: String ) -> some View {
        Button(action: {
            emojis = emojisArr.shuffled()
            for i in isGray.indices {
                isGray[i] = false
            }
            isGray[numTheme].toggle()
            chooseTheme = true
            currentTheme = numTheme + 1
        }, label: {
            VStack(alignment: .center) {
                // Image at the top
                Image(systemName: label)
                    .resizable() // Allows the image to be resized if needed
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35) // Ensures all images have the same size
                
                // Text under the image
                Text(themeNames[numTheme])
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .frame(width: 80)
            }

        })
        .disabled(isGray[numTheme] == true)

        
    }
        
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(getColor(for: currentTheme))
    }
    
    
    var buttons: some View {
        HStack(alignment: .center, spacing: 0.0) {
//            cardRemover
            Spacer()
            theme1
            Spacer()
            theme2
            Spacer()
            theme3
            Spacer()
//            cardAdder
        }
        .padding(.horizontal)
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
    }

    func cardAdjustment(by offset : Int, image: String) -> some View {
        Button(action: {
                cardCount += offset
        }, label: {
            Image(systemName: image)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count || chooseTheme == false)
        
    }
    
    var cardRemover: some View {
        cardAdjustment(by: -1, image: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardAdjustment(by: 1, image: "rectangle.stack.badge.plus.fill")
    }
    
    func getColor(for state: Int) -> Color {
        switch state {
        case 1:
            return .blue
        case 2:
            return .orange
        case 3:
            return .red
        default:
            return .orange
        }
    }
}





struct CardView: View {
    let content: String
    @State var isFaceUP: Bool = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            //            let base = Circle()
            Group {
                base.fill(Color.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUP ? 1 : 0)
            base.fill().opacity(isFaceUP ? 0 : 1)
        }
        .onTapGesture(perform: {
            isFaceUP.toggle()
        })
    }
}
    
#Preview {
    ContentView()
}
