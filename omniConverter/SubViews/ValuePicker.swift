//
//  ValuePicker.swift
//  omniConverter
//
//  Created by John Florian on 12/29/24.
//
// https://medium.com/@Barbapapapps/beyond-basics-implementing-a-custom-picker-in-swiftui-88c01e283ac1
// https://gist.github.com/juliensagot/42c7febb1418b5f58a8b1702793a6a73

import SwiftUI

public struct ValuePicker<SelectionValue: Hashable, TitleContent: View, Content: View>: View {
  private let title: TitleContent
//  private let title: LocalizedStringKey?
  private let selection: Binding<SelectionValue>
  private let isSelectorOpen: Binding<Bool>
  private let content: Content
  
  public init(
    @ViewBuilder title: () -> TitleContent,
//    _ title: LocalizedStringKey? = nil,
    selection: Binding<SelectionValue>,
    isSelectorOpen: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title()
    self.selection = selection
    self.isSelectorOpen = isSelectorOpen
    self.content = content()
  }
  
  public var body: some View {
    NavigationLink {
      List {
        _VariadicView.Tree(ValuePickerOptions(selectedValue: selection, isSelectorOpen: isSelectorOpen)) {
          content
        }
      }
      .onAppear(perform: { isSelectorOpen.wrappedValue = true })
//      .navigationTitle(title ?? "")
#if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
#endif
    } label: {
//      VStack {
//        if let title = title {
//          Text(title)
//            .font(.footnote.weight(.medium))
//            .foregroundStyle(.secondary)
//        }
//        Text(title ?? "")
        title
//        Text(verbatim: String(describing: selection.wrappedValue))
//      }
    }
  }
}

private struct ValuePickerOptions<Value: Hashable>: _VariadicView.MultiViewRoot {
  private let selectedValue: Binding<Value>
  private let isSelectorOpen: Binding<Bool>
  
  init(selectedValue: Binding<Value>,
       isSelectorOpen: Binding<Bool>) {
    self.selectedValue = selectedValue
    self.isSelectorOpen = isSelectorOpen
  }
  
  @ViewBuilder
  func body(children: _VariadicView.Children) -> some View {
    Section {
      ForEach(children) { child in
        ValuePickerOption(
          selectedValue: selectedValue,
          value: child[CustomTagValueTraitKey<Value>.self],
          isSelectorOpen: isSelectorOpen
        ) {
          child
        }
      }
    }
//    .navigationBarBackButtonHidden(true)
  }
}

private struct ValuePickerOption<Content: View, Value: Hashable>: View {
  @Environment(\.dismiss) private var dismiss
  
  private let selectedValue: Binding<Value>
  private let value: Value?
  private let isSelectorOpen: Binding<Bool>
  private let content: Content
  
  init(
    selectedValue: Binding<Value>,
    value: CustomTagValueTraitKey<Value>.Value,
    isSelectorOpen: Binding<Bool>,
    @ViewBuilder _ content: () -> Content
  ) {
    self.selectedValue = selectedValue
    self.value = if case .tagged(let tag) = value {
      tag
    } else {
      nil
    }
    self.isSelectorOpen = isSelectorOpen
    self.content = content()
  }
  
  var body: some View {
    Button(
      action: {
        if let value {
          selectedValue.wrappedValue = value
        }
        isSelectorOpen.wrappedValue = false
        dismiss()
      },
      label: {
        HStack {
          content
            .tint(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
          
          if isSelected {
            Image(systemName: "checkmark")
              .foregroundStyle(.tint)
              .font(.body.weight(.semibold))
              .accessibilityHidden(true)
          }
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
      }
    )
  }
  
  private var isSelected: Bool {
    selectedValue.wrappedValue == value
  }
}

extension View {
  public func pickerTag<V: Hashable>(_ tag: V) -> some View {
    _trait(CustomTagValueTraitKey<V>.self, .tagged(tag))
  }
}

private struct CustomTagValueTraitKey<V: Hashable>: _ViewTraitKey {
  enum Value {
    case untagged
    case tagged(V)
  }
  
  static var defaultValue: CustomTagValueTraitKey<V>.Value {
    .untagged
  }
}



#Preview {
  PreviewContent()
}

private struct PreviewContent: View {
  @State private var selection = "John"
  
  var body: some View {
    NavigationStack {
      List {
//        ValuePicker("Name", selection: $selection, isSelectorOpen: false) {
//          ForEach(["John", "Jean", "Juan"], id: \.self) { name in
//            Text(verbatim: name)
//              .pickerTag(name)
//          }
//        }
      }
      .navigationTitle("Custom Picker")
    }
  }
}
