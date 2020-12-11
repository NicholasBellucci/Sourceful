//
//  DefaultSourceCodeTheme.swift
//  SourceEditor
//
//  Created by Louis D'hauwe on 24/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

public struct DefaultSourceCodeTheme: SourceCodeTheme {
	
	public init() {
		
	}
	
	private static var lineNumbersColor: Color {
		return Color(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
	}
	
	public let lineNumbersStyle: LineNumbersStyle? = LineNumbersStyle(font: Font(name: "Menlo", size: 16)!, textColor: lineNumbersColor)
	
	public let gutterStyle: GutterStyle = GutterStyle(backgroundColor: Color(red: 21/255.0, green: 22/255, blue: 31/255, alpha: 1.0), minimumWidth: 32)
	
	public let font = Font(name: "Menlo", size: 15)!
	
	public let backgroundColor = Color(red: 42/255.0, green: 42/255, blue: 48/255, alpha: 1.0)
	
	public func color(for syntaxColorType: SourceCodeTokenType) -> Color {
		
		switch syntaxColorType {
		case .plain:
			return .white
			
		case .number:
			return Color(red: 116/255, green: 109/255, blue: 176/255, alpha: 1.0)
			
		case .string:
			return Color(red: 208/255, green: 168/255, blue: 255/255, alpha: 1.0)
			
		case .identifier:
			return Color(red: 20/255, green: 156/255, blue: 146/255, alpha: 1.0)
			
		case .keyword:
			return Color(red: 252/255, green: 95/255, blue: 163/255, alpha: 1.0)
			
		case .comment:
			return Color(red: 69/255, green: 187/255, blue: 62/255, alpha: 1.0)
			
		case .editorPlaceholder:
			return backgroundColor

        case .otherDeclaration:
            return Color(red: 65/255, green: 161/255, blue: 192/255, alpha: 1.0)
		}
		
	}
	
}
