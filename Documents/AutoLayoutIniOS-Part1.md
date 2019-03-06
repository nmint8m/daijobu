## Auto Layout In iOS - Part 1 - What is Auto Layout?

*Written by: __Nguyễn Minh Tâm__*

> Nếu bạn đã có kiến thức cơ bản về auto layout, có thể trực tiếp bỏ qua phần 1.
> Tham khảo những phần khác:
> 
>> [Phần 1][Part 1]: Giới thiệu auto layout và các khái niệm cơ bản trong auto layout.
>> 
>> [Phần 2][Part 2]: Phân tích một constraint.
>> 
>> [Phần 3][Part 3]: Auto layout không dùng constraint


### Auto layout là gì?

Auto layout có nhiệm vụ tính toán kích thước và vị trí của tất cả các view trong hệ thống view (view hierarchy), dựa vào constraint được cài đặt trong các view đó.

Nhờ hệ thống constraint trong design này mà nó cho phép chúng ta build UI có thể thay đổi linh hoạt theo sự thay đổi của cả bên trong (internal change) và bên ngoài (external change)

#### External change

External change xảy ra khi size hay hình dạng của supperview thay đổi.

Hầu hết những thay đổi này thường xảy ra lúc runtime và đương nhiên app sẽ phải yêu cầu UI phản hồi liên tục ứng với những thay đổi đó. 

Một ví dụ khác nữa, đối với yêu cầu support cho những screen size khác nhau, app cần phải hiển thị phù hợp tương ứng với từng môi trường. Mặc dù đối với trường hợp này, screen size không thay đổi trong suốt runtime, việc tạo nên adaptive interface sẽ hỗ trợ app chạy mượt trên cả iPhone 4S, iPhone 6 Plus và cả trên iPad.

#### Internal change

Internal change xảy ra khi size của view / control ở phía bên trong UI thay đổi.

Khi content của app thay đổi, chính content này có thể yêu cầu layout khác so với layout cũ. Ví dụ phổ biến nhất là sự thay đổi của nội dung text / image.

Bên cạnh đó, quá trình quốc tế hoá bắt buộc app phải có khả năng thay đổi tương thích với từng ngôn ngữ, vùng miền và văn hoá khác nhau. Layout cho một app mang tính quốc tế thực sự cần quan tâm đến vấn đề này, làm sao để hiển thị một cách chính xác ứng với tất cả các ngôn ngữ và vùng miền mà app đó hỗ trợ.

Sự quốc tế hoá có 3 tác động chính lên layout:

- Khi thay đổi ngôn ngữ, các label yêu cầu chiếm một lượng diện tích khác. Chả hạn như tiếng Đức sẽ chiếm diện tích nhiều hơn tiếng Anh, trong khi đó thường thì tiếng Nhật sẽ tốn ít hơn.

- Format sử dụng cho ngày tháng hay số liệu có thể bị thay đổi theo từng vùng miền, ngay khi ngôn ngữ vẫn giữ nguyên. Mặc dù những thay đổi này tinh vi hơn nhiều so với thay đổi ngôn ngữ, UI vẫn cần phải điều chỉnh lại cho phù hợp với sự biến đổi nhỏ về mặt kích thước đó.

- Thay đổi ngôn ngữ không chỉ thay đổi kích thước của text, mà còn tái cấu trúc lại layout. Đối với từng loại ngôn ngữ khác nhau sẽ có thứ tự sắp xếp layout (layout direction) khác nhau. Ví dụ điển hình như, tiếng Anh có layout direction trái sang phải, nhưng tiếng Ả-rập lại có layout từ phải sang trái. Xét về tổng thể, thứ tự các thành phần trong UI phải tương xứng với layout direction. Nếu một button nằm ở góc dưới bên phải của view ở tiếng Anh, thì nó phải ở góc dưới bên trái ở tiếng Ả-rập.

- Nếu iOS app support dynamic type, đồng nghĩa với việc người dùng có thể thay đổi font size trong app. Điều này dẫn tới việc thay đổi chiều cao lẫn chiều rộng của mọi thành phần chứa text trong UI. Nếu người dùng đổi font size khi app đang chạy, cả font lẫn layout đều phải điều chỉnh.

### Auto layout vs Frame-based layout

Có ba cách chính để sắp xếp UI:

- Programmatically lay out UI

- Sử dụng autoresizing mask để tự động hoá việc điều chỉnh ứng với external change

- Auto layout

#### Programmatically lay out UI

Về cơ bản app sắp xếp UI bởi việc setting frame cho mỗi view trong view hierarchy. Frame giúp xác định origin, height và width của view nằm trong hệ quy chiếu của superview.

![AutoLayoutIniOS-Part1-1][Image 1]

Theo nhiều cách, thì define frame của view là cách linh hoạt và chính xác nhất. Bởi vì tự chúng ta cần phải quản lý tất cả các thay đổi đó, chính vì thế nên chỉ một UI đơn giản, cần nhiều effort để design, debug và maintain. Việc tạo ra một adaptive UI đúng nghĩa đối với trường hợp này càng khó khi độ phức tạp view càng lớn.

#### Autoresizing mask

Sử dụng autoresizing mask giúp giảm nhẹ effort phải bỏ ra. Autoresizing mask xác định cái cách view frame thay đổi đối ứng với cách superview frame thay đổi. Giải pháp này đơn giản hoá công việc quản lý layout tương thích với external change

Tuy nhiên, autoresizing mask chỉ hỗ trợ đối với một số layout. Đối với UI phức tạp, chúng ta cần sử dụng autoresizing mask kèm thêm programmatically lay out UI. Ngoài ra, autoresizing mask chỉ điều chỉnh theo external change, không hỗ trợ cho internal change.

Autoresizing mask về cơ bản là một giải pháp tương tự programmatic layout, tuy nhiên auto layout lại là một khái niệm khác hẳn. Thay vì nghĩ đến view frame, chúng ta sẽ phân tích về các mối quan hệ giữa chúng.


#### Auto layout

Auto layout điều khiển UI bằng cách sử dụng một chuỗi các constraint. Một constraint mô tả một mối quan hệ giữa 2 view. Sau đó, auto layout tính toán size và vị trí của mỗi view dựa trên những constraint này. Điều này giúp cho layout thay đổi linh hoạt cho cả internal change và external change.

![AutoLayoutIniOS-Part1-2][Image 2]

Để mastering auto layout cần:

- Hiểu logic của constraint-based layout

- API

Phần tiếp theo mình sẽ phân tích sâu hơn về constraint trong auto layout.

### More

Đọc tiếp: 

- [Auto Layout In iOS For Beginner - Part 2 - Anatomy of a Constraint][Part 2]

- [Auto Layout In iOS For Beginner - Part 3 - Auto Layout Without Constraints][Part 3]

Quay lại [Daijobu Project][Daijobu]

### Reference

#### Getting Started

[Understanding Auto Layout][Reference 1]

[Auto Layout Without Constraints][Reference 2]

[Anatomy of a Constraint][Reference 3]

#### Auto Layout Cookbook

[Stack Views][Reference 4]

[Views with Intrinsic Content Size][Reference 5]




[Image 1]: https://github.com/nmint8m/daijobu/blob/master/Documents/Images/AutoLayoutIniOS-Part1-1.png 

[Image 2]: https://github.com/nmint8m/daijobu/blob/master/Documents/Images/AutoLayoutIniOS-Part1-2.png

[Part 1]: https://github.com/nmint8m/daijobu/blob/master/Documents/AutoLayoutIniOS-Part1.md

[Part 2]: https://github.com/nmint8m/daijobu/blob/master/Documents/AutoLayoutIniOS-Part2.md

[Part 3]: https://github.com/nmint8m/daijobu/blob/master/Documents/AutoLayoutIniOS-Part3.md

[Daijobu]: https://github.com/nmint8m/daijobu

[Reference 1]: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1 "Understanding Auto Layout"

[Reference 2]: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutWithoutConstraints.html#//apple_ref/doc/uid/TP40010853-CH8-SW1 "Auto Layout Without Constraints" 

[Reference 3]: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW1 "Anatomy of a Constraint"

[Reference 4]: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html#//apple_ref/doc/uid/TP40010853-CH11-SW1 "Stack Views"

[Reference 5]: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html#//apple_ref/doc/uid/TP40010853-CH13-SW1 "Views with Intrinsic Content Size"

