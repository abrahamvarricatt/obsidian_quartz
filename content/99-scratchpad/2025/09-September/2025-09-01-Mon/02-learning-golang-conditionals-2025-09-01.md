---
tags:
  - golang
  - boot-dot-dev
created: 2025-09-01
modified: []
title: ""
---
###### References


---
# Introduction

Am going to begin the section about conditionals. I wonder how this compares to other languages?

Immediate takeaway,

> `if` statements in Go do not use parentheses around the condition

Think this is similar to python. But IIRC, we do need the parentheses in javascript. The example they use,

```go
if height > 4 {
    fmt.Println("You are tall enough!")
}
```

The comparison operators look like standard stuff. 

Oh. We can have full expressions as part of the conditional check in an IF block. Here is their example,

```go
if length := getLength(email); length < 1 {
    fmt.Println("Email is invalid")
}
```
Something notable is that the variables created this way are *only* available within the scope of the `if` body. They are not available further below. 

`swtich` statements exist in #golang , similar to C but their default behaviour is different. In #golang the `break` is implicit at the end of the switch statement. If we want execution to continue, it must be explicitly set using the `fallthrough` keyword. Here is the example they use, 

```go
func getCreator(os string) string {
    var creator string
    switch os {
    case "linux":
        creator = "Linus Torvalds"
    case "windows":
        creator = "Bill Gates"

    // all three of these cases will set creator to "A Steve"
    case "macOS":
        fallthrough
    case "Mac OS X":
        fallthrough
    case "mac":
        creator = "A Steve"

    default:
        creator = "Unknown"
    }
    return creator
}
```

The `default` at the end works as we'd expect. 

I wonder if, similar to the `IF` statement, we can have code assignments as part of the conditional  check for a `swtich`  ? 

