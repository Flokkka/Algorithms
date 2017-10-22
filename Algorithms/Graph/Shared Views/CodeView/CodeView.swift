//
//  CodeView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/4/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class CodeView: UIView {
    
    private var languagePicker: UIPickerView!
    private var textView: UITextView!
    private var textStorage: SyntaxHighlightTextStorage!
    public var algorithm: AlgorithmInterface! {
        didSet {
            if algorithm is SortInterface {
                createPickerView()
            }
            setLanguage(.swift)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
    
    private func initSelf() {
        createTextView()
    }
    
    private func createTextView() {
        textStorage = SyntaxHighlightTextStorage()
        let newTextViewRect = bounds
        let layoutManager = NSLayoutManager()
        let containerSize = CGSize(width: newTextViewRect.width, height: CGFloat.greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        textView = UITextView(frame: newTextViewRect, textContainer: container)
        textView.isScrollEnabled = true
        textView.isSelectable = false
        textView.contentSize = textStorage.size()
        addSubview(textView)
    }
    
    private func createPickerView() {
        languagePicker = UIPickerView(frame: CGRect(x: frame.size.width - 70, y: 0, width: 60, height: 50))
        languagePicker.delegate = self
        languagePicker.dataSource = self
        addSubview(languagePicker)
    }
    
    private func setLanguage(_ language: Languages) {
        let attrs = [NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        let algoClassName = String(describing: algorithm).components(separatedBy: [".", "("])[2]
        let ext = algorithm is SortInterface ? String(describing: language) : ""
        let path = Bundle.main.path(forResource: "SC" + algoClassName, ofType: ext)
        var content: String!
        if let path = path {
            content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        else {
            content = "\(algorithm.name) not implemented in \(language.string) :/"
        }
        let attrString = NSAttributedString(string: content, attributes: attrs)
        textStorage.deleteCharacters(in: NSMakeRange(0, textStorage.backingStore.length))
        textStorage.append(attrString)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = bounds
    }
}

extension CodeView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Languages.mapper.count - 1 //ignore pseudocode option
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pLabel = UILabel()
        pLabel.textAlignment = .center
        pLabel.text = Languages(rawValue: row)!.string
        return pLabel
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setLanguage(Languages(rawValue: row)!)
    }
}
