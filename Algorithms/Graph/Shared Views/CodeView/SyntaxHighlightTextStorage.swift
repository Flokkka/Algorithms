//
//  SyntaxHighlightTextStorage.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/4/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

//code from TextKit Tutorial (https://www.raywenderlich.com/77092/text-kit-tutorial-swift)
class SyntaxHighlightTextStorage: NSTextStorage {
    
    public let backingStore = NSMutableAttributedString()
    private var replacements: [String : [NSAttributedStringKey : UIColor]] = [:]
    
    override init() {
        super.init()
        createHighlightPatterns()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    required init(itemProviderData data: Data, typeIdentifier: String) throws {
        fatalError("init(itemProviderData:typeIdentifier:) has not been implemented")
    }
    
    public override var string: String {
        return backingStore.string
    }
    
    public override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedStringKey : Any] {
        return backingStore.attributes(at: location, effectiveRange: range)
    }
    
    public override func replaceCharacters(in range: NSRange, with str: String) {
        beginEditing()
        backingStore.replaceCharacters(in: range, with: str)
        edited([.editedAttributes, .editedCharacters], range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    public override func processEditing() {
        performReplacementsForRange(editedRange)
        super.processEditing()
    }
    
    public override func setAttributes(_ attrs: [NSAttributedStringKey : Any]?, range: NSRange) {
        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    private func applyStylesToRange(searchRange: NSRange) {
        let normalAttrs = [NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        for (pattern, attributes) in replacements {
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            regex.enumerateMatches(in: backingStore.string, options: [], range: searchRange) { match, flags, stop in
                guard match != nil else { return }
                let matchRange = match!.range(at: 1)
                addAttributes(attributes as [NSAttributedStringKey : Any], range: matchRange)
                
                let maxRange = matchRange.location + matchRange.length
                if maxRange + 1 < length {
                    addAttributes(normalAttrs, range: NSMakeRange(maxRange, 1))
                }
            }
        }
    }
    
    private func performReplacementsForRange(_ changedRange: NSRange) {
        var extendedRange = NSUnionRange(changedRange, NSString(string: backingStore.string).lineRange(for: NSMakeRange(changedRange.location, 0)))
        extendedRange = NSUnionRange(changedRange, NSString(string: backingStore.string).lineRange(for: NSMakeRange(NSMaxRange(changedRange), 0)))
        applyStylesToRange(searchRange: extendedRange)
    }
    
    private func createHighlightPatterns() {
        if let path = Bundle.main.path(forResource: "LanguageSyntax", ofType: "plist") {
            let languageDict = NSDictionary(contentsOfFile: path)!
            for color in languageDict {
                let infos = color.value as! [NSString]
                let rgbString = infos[0]
                let scanner = Scanner(string: rgbString as String)
                var rgb: UInt64 = 0
                scanner.scanHexInt64(&rgb)
                let textAttributes = [NSAttributedStringKey.foregroundColor : UIColor(rgb: Int(rgb))]
                for e in infos[1..<infos.count] {
                    replacements["\\b(\(e))\\b"] = textAttributes
                }
            }
        }
        else {
            print("LanguageSyntax.plist not found")
        }
    }
    
}
