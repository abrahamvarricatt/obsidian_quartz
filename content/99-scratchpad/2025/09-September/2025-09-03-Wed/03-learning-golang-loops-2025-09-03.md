---
tags:
  - golang
  - boot-dot-dev
created: 2025-09-03
modified: []
title: ""
---
###### References


---
# Introduction

Have reached the chapter on loops. Glancing ahead, it feels unusually small - just 6 sections. 🤷‍♂️

Here is what a basic loop looks like,

```go
for INITIAL; CONDITION; AFTER{
  // do something
}
```

For the most part, looks very similar to C. Here is some code that prints 0 to 9,
```go
for i := 0; i < 10; i++ {
  fmt.Println(i)
}
```

we can skip the `CONDITION` part of `for` loops. Not just that - looks like we can skip them all if we want. Which means this is valid,

```go
for INITIAL; ; AFTER {
}
```

The above is an infinite loop.

Go does not have the concept of a `while` loop. Because the `for` loop allows to skip sections, we can reuse it for the same purpose. eg;
```go
for CONDITION {
    // do stuff while CONDITION is true
}
```

