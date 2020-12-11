//
//  SourceCodeTextEditor.swift
//
//  Created by Andrew Eades on 14/08/2020.
//

import Foundation
import SwiftUI

public struct SourceCodeTextEditor: NSViewRepresentable {
    public struct Customization {

        var insertionPointColor: Sourceful.Color
        var lexerForSource: Lexer
        var theme: SourceCodeTheme
        var didBeginEditing: (() -> ())?
        var didChange: ((String) -> ())?
        
        /// Creates a **Customization** to pass into the *init()* of a **SourceCodeTextEditor**.
        ///
        /// - Parameters:
        ///     - didChangeText: A SyntaxTextView delegate action.
        ///     - lexerForSource: The lexer to use (default: SwiftLexer()).
        ///     - insertionPointColor: To customize color of insertion point caret (default: .white).
        ///     - textViewDidBeginEditing: A SyntaxTextView delegate action.
        ///     - theme: Custom theme (default: DefaultSourceCodeTheme()).
        public init(
            insertionPointColor: Sourceful.Color = .white,
            lexerForSource: Lexer = SwiftLexer(),
            theme: SourceCodeTheme = DefaultSourceCodeTheme(),
            didBeginEditing: (() -> ())? = nil,
            didChange: ((String) -> ())? = nil
        ) {
            self.insertionPointColor = insertionPointColor
            self.lexerForSource = lexerForSource
            self.theme = theme
            self.didBeginEditing = didBeginEditing
            self.didChange = didChange
        }
    }
    
    @Binding private var text: String
    private var custom: Customization
    
    public init(
        text: Binding<String>,
        customization: Customization = Customization()
    ) {
        _text = text
        self.custom = customization
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeNSView(context: Context) -> SyntaxTextView {
        let wrappedView = SyntaxTextView()
        wrappedView.delegate = context.coordinator
        wrappedView.theme = custom.theme
        wrappedView.contentTextView.insertionPointColor = custom.insertionPointColor
        
        context.coordinator.wrappedView = wrappedView
        context.coordinator.wrappedView.text = text
        
        return wrappedView
    }
    
    public func updateNSView(_ view: SyntaxTextView, context: Context) {
        context.coordinator.wrappedView.text = text
        view.selectedRanges = context.coordinator.selectedRanges
    }
}

extension SourceCodeTextEditor {
    public class Coordinator: SyntaxTextViewDelegate {
        let parent: SourceCodeTextEditor
        var wrappedView: SyntaxTextView!
        var selectedRanges: [NSValue] = []
        
        init(_ parent: SourceCodeTextEditor) {
            self.parent = parent
        }
        
        public func lexerForSource(_ source: String) -> Lexer {
            parent.custom.lexerForSource
        }
        
        public func didChangeText(_ syntaxTextView: SyntaxTextView) {
            DispatchQueue.main.async {
                self.parent.text = syntaxTextView.text
            }

            selectedRanges = syntaxTextView.contentTextView.selectedRanges
            parent.custom.didChange?(syntaxTextView.text)
        }
        
        public func textViewDidBeginEditing(_ syntaxTextView: SyntaxTextView) {
            parent.custom.didBeginEditing?()
        }
    }
}
