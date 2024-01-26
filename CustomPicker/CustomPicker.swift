//
//  CustomPicker.swift
//  CustomPicker
//
//  Created by Federico G. Ramos on 22.01.24.
//

import SwiftUI


struct CustomPicker<SelectionValue, Content>: View where SelectionValue == Content.Element, Content: RandomAccessCollection, Content.Element: Identifiable & Equatable, Content.Element.ID == String {
    
    @Binding var selection: SelectionValue?
    let items: () -> Content
    
    @State var isPicking = false
    @State var hoveredItem: SelectionValue?
    @Environment(\.isEnabled) var isEnabled
    
    let buttonHeight: CGFloat = 44
    let arrowSize: CGFloat = 16
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        
        // Select Button - Selected item
        HStack {
            Text(selection?.id.capitalized ?? "Select")
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Spacer()
            Text(">")
                .rotationEffect(isPicking ? Angle(degrees: 90) : Angle(degrees: -90))
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
        .frame(height: buttonHeight)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color("PickerColor"))
                .stroke(Color.primary, lineWidth: 2.2)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            isPicking.toggle()
        }
        // Picker
        .overlay(alignment: .topLeading) {
            VStack {
                if isPicking {
                    Spacer(minLength: buttonHeight + 10)
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(items()) { item in
                                
                                Divider()
                                
                                Button {
                                    
                                    selection = item
                                    isPicking.toggle()
                                    
                                } label: {
                                    
                                    Text(item.id.capitalized)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                        .frame(height: buttonHeight)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.horizontal, 10)
                                        .background {
                                            RoundedRectangle(cornerRadius: cornerRadius)
                                                .fill(hoveredItem == item ? Color.accentColor.opacity(0.8) : Color.clear)
                                                .padding(.horizontal, 8)
                                                .padding(.bottom, 10)
                                                .offset(y: 5)
                                        }
                                        .onHover { isHovered in
                                            if isHovered {
                                                hoveredItem = item
                                            }
                                        }
                                }
                                .buttonStyle(.plain)
                                
                                Divider()
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .scrollIndicators(.never)
                    .frame(height: 200)
                    .background(Color("PickerColor"))
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.primary, lineWidth: 2.2)
                    )
                    .transition(.scale(scale: 0.8, anchor: .top).combined(with: .opacity).combined(with: .offset(y: -10)))
                }
            }

        }
        .padding(.horizontal, 12)
        .opacity(isEnabled ? 1.0 : 0.6)
        .font(.custom("RetroComputer", size: 13))
        .animation(.easeInOut(duration: 0.12), value: isPicking)
        .sensoryFeedback(.selection, trigger: selection)
        .zIndex(1)
    }
}
#Preview {
    VStack {
        CustomPicker(selection: .constant(nil)) {
            Fruit.allCases
        }
    }
    .preferredColorScheme(.light)
    .frame(width: 280, height: 280, alignment: .top)
    .padding()
}
