#CXPassKit

A passkit to help you handle saving `.pkpass` file to document folder in application, and `pass` state in passbook.

---
**How to use**

`passTypeIdentifier` is the specific identifier of your pass. It should be the same value in your `pass.json`.

```Objective-C
+ (PKPass *)passInDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
+ (PKPass *)passInPassBookWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
```

return the specific `pass` in passbook or document folder.

```Objective-C
+ (NSArray *)passesInDocument;
+ (NSArray *)passesInPassBook;
```

return all `pass` in passbook or document folder.

```Objective-C
+ (BOOL)hasPassFileAtDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
+ (BOOL)hasPassInPassbookWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
```

check if `pass` is exist.


```Objective-C
+ (void)downloadWithPassTypeIdentifier:(NSString *)passTypeIdentifier fromURL:(NSURL *)url completionBlock:(downloadCompletionBlock)block;
```

To downloand `pass` to document folder in application.
*the file will be named as `passTypeIdentifier`.pkpass.

```Objective-C
+ (void)presentPassWithPassTypeIdentifier:(NSString *)passTypeIdentifier delegateViewController:(UIViewController *)delegateVC completionBlock:(presentCompletionBlock)block;
```

Using this method to present `pass`.

```Objective-C
+ (void)removePassWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
```

Using this method to remove specific `pass`.

**Coming soon**:

* Replace method

**Supports**:
* iOS 5.0 or later.
* Useing ARC
* Required frameworks: PassKit. (suggestion to mark this as optional at  `Build Phases` -> `Link Binary With Libraries`)


---
##Contact
<a href="https://twitter.com/taterctl" class="twitter-follow-button" data-show-count="ture" data-lang="zh-tw">跟隨 @taterctl</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>

---
##License

Copyright (c) 2013 Chris Xu, Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.