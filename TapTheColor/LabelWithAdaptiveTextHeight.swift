//  Created by https://github.com/backslash-f on 12/19/14.
//

/*
 Designed with single-line UILabels in mind, this subclass 'resizes' the label's text (it changes the label's font size)
 everytime its size (frame) is changed. This 'fits' the text to the new height, avoiding undesired text cropping.
 Kudos to this Stack Overflow thread: bit.ly/setFontSizeToFillUILabelHeight
 */

import Foundation
import UIKit

class LabelWithAdaptiveTextHeight: UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        font = fontToFitHeight()
    }
    
    private func fontToFitHeight() -> UIFont {
        
        var minFontSize: CGFloat = 20
        var maxFontSize: CGFloat = 90
        var fontSizeAverage: CGFloat = 0
        var textAndLabelHeightDiff: CGFloat = 0
        
        while (minFontSize <= maxFontSize) {
            
            fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 2
            
            guard let charsCount = text?.count, charsCount > 0 else {
                break
            }
            
            if let labelText: String = text {
                let labelHeight = frame.size.height
                
                let testStringHeight = labelText.size(withAttributes:[NSAttributedString.Key.font: font.withSize(fontSizeAverage)]).height
                
                textAndLabelHeightDiff = labelHeight - testStringHeight
                
                if (fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize) {
                    if (textAndLabelHeightDiff < 0) {
                        return font.withSize(fontSizeAverage - 1)
                    }
                    return font.withSize(fontSizeAverage)
                }
                
                if (textAndLabelHeightDiff < 0) {
                    maxFontSize = fontSizeAverage - 1
                    
                } else if (textAndLabelHeightDiff > 0) {
                    minFontSize = fontSizeAverage + 1
                    
                } else {
                    return font.withSize(fontSizeAverage)
                }
            }
        }
        return font.withSize(fontSizeAverage)
    }
}
