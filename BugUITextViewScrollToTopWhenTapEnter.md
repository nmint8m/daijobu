## Bug UITextView scroll to top when tap enter

*[Bug on iOS 7 & 8]*

*Written by: __Nguyen Minh Tam__*

### How to deal with this:

```swift
textView.layoutManager.allowsNonContiguousLayout = false
```

### Reference:

[Hayatomo's solution](http://hayatomo.com/1307)
