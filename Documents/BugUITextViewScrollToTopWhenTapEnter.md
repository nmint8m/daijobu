## Bug UITextView scroll to top when tap enter

*[Bug on iOS 7 & 8]*

*Written by: __Nguyen Minh Tam__*

### How to deal with this

```swift
textView.layoutManager.allowsNonContiguousLayout = false
```

### More

Quay lại [Daijobu Project][Daijobu]

### Reference

[Hayatomo's solution] [Reference 1]

[Daijobu]: https://github.com/nmint8m/daijobu

[Reference 1]: http://hayatomo.com/1307