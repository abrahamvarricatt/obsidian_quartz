---
tags:
  - golang
created: 2025-08-31
modified: []
---
###### References


---
# Introduction

Some random notes I took when following the basic #golang tutorial from [[https://boot.dev|Boot.dev]]

Here is a basic "Hello World" program in Go,

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello World")
}
```

Going to skip mentioning the package and import moving forward - unless it's something new. 
Here is how to declare variables,
```go
func main() {
    // variable initialization
    var smsSendingLimit int
    var costPerSMS float64
    var hasPermission bool
    var username string
    
    fmt.Printf("%v %.2f %v %q\n", smsSendingLimit, costPerSMS, hasPermission, username)
}
```

The output of the above looks like this,
```
0 0.00 false ""
```

I find the `%v` working for both int and bool weird. Like - if we're going to reuse characters, why not the same for all? And why `%q` for strings? That's new. Why not the usual `%s` ?

The earlier seems to be the "sad" way of declaring variables. The better approach seems to be this,
```go
mySkillIssues := 42
```
The walrus operator declares the variable and assigns it a value at the same time. The language uses type inference to puzzle it out. 

Oh. When the println() method is called like this,
```go
fmt.println(messageStart, age, messageEnd)
```
in the output, a space is automatically inserted between the characters. That's convenient! 

Got some explanations about the boilerplate. 

`package main` -> lets the compiler know that we want the code to compile and run as a standalone application. The alternative is that we might have been building a library. 

`import "fmt"` -> imports `fmt` from the standard library. 

`func main()` -> defines the entrypoint. 

Here is an interest website/dictionary;
https://techterms.com/definition/truncate

In Go, when we convert between types - float to int specifically, we lose data. The variable is not rounded - it is truncated. 

Hmm... now that I think about it, I don't feel I've actually done that kind of conversion in any of my day jobs. 🤔

Here is a list of default go types,
```go
bool
string
int
uint
byte
rune
float64
complex128
```

What the heck is a rune type? A bit of searching tells me that it is a unicode codepoint. Usually it is equivalent to int32. 

Constants are declared using the `const` keyword.

Finally got an answer. The `%v` that is used in `fmt.Printf()` is a default. It can be used for any variable. 

`fmt.Printf()` will print a formatted string to STDOUT and
`fmt.Sprintf()` will return the formatted string (it does not do any printing directly)

Here is a new way of using the `import` keyword,

```go
import (
    "fmt"
    "unicode/utf8"
)
```

random website = https://emojipedia.org/bear

To measure unicode characters in Go, we need to use this,
```go
const name = "🐻"
utf8.RuneCountInString(name)
```

above will return 1. But if you use `len(name)`, it will return 4. 


Just finished the variables section. That was a lot more than I was expecting!

