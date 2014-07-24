PrediKit
=======

PrediKit allows you to write `NSPredicate`s and `NSExpression`s using native Swift code. Just write an expression like:

    NSPredicate.withClosure { obj in
        obj["numberOfDesiredItems"] < countElements(obj["items"])
    }

And you'll get an equivalent predicate without having to fumble around with the NSPredicate format syntax.

Features
-------

PrediKit overloads many Swift features with variants that return equivalent NSExpressions:

* Arithmetic operators (`+`, `-`, `*`, `/`, and `%`)
* Bitwise operators (`\<\<`, `\>\>`,  `&`,  `|`,  `^`, and `~`)
* `pow(x, y)`, `sqrt(x)`, `log10(x)`, `log(x)`, `exp(x)`, `floor(x)`, `ciel(x)`, `abs(x)`, and `trunc(x)`
* `countElements(list)`, `minElement(list)`, and `maxElement(list)`
* `uppercaseString` and `lowercaseString` properties on `NSExpression`
* `distanceFromLocation(loc)` method on `NSExpression`
* `arc4random()` and `arc4random_uniform(x)`, giving a different number each time the expression is evaluated
* New `dynamicDate` class property on `NSDate`, giving the date at the time the expression is evaluated

It also overloads a number of boolean operations to return NSPredicates:

* Basic comparisons (`==`, `!=`, `<`, `<=`, `>`, and `>=`), plus `any()` and `all()` functions to expose NSPredicate's ability to search inside a collection
* Basic logic operations (`&&`, `||`, and `!`)
* `contains(haystack, needle)`
* Limited support for testing ranges (including ranges of NSExpressions constructed with `..<` or `...`) with `~=`

Finally, it includes the Unicode set operators `∪` (union), `∩` (intersect), and `∖` (minus).

Bugs
-----

Currently these operators are available everywhere in your code. I would like to use a wrapper struct to avoid mistaken uses, but the Swift compiler choked when I tried this.

Any other bugs should be reported [on GitHub](https://github.com/brentdax/PrediKit). Pull requests are welcome.

Author
-----

Brent Royal-Gordon, Architechies <brent@architechies.com>

Copyright
-------

Copyright (C) 2014 Architechies. MIT licensed:

> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
