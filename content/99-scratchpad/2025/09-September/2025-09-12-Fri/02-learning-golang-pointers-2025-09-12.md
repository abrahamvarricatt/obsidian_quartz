---
tags:
  - golang
  - boot-dot-dev
created: 2025-09-12
modified: []
title: ""
---
###### References


---
# Introduction

The next segment is about pointers. I wonder if these are similar to C?

At first glance, it looks similar. 

Here is how to define a pointer,
```go
var p *int
```

The `*` syntax defines a pointer. 

And the `&` operator generates a pointer to its operand,
```go
myString := "hello"
myStringPtr := &myString
```

We can use the `*` operator to dereference a pointer to get back its original value. 

```go
*myStringPtr = "world"                              // set myString through the pointer
fmt.Printf("value of myString: %s\n", *myStringPtr) // read myString through the pointer
// value of myString: world
```

Am not sure what this means yet - but the course says "Unlike C, Go has no pointer arithmetic". 

I do not understand this part about pointers to structs. i.e. the following is invalid,
```go
msgTotal := *analytics.MessagesTotal
```

Instead one of these might be fine?
```go
msgTotal := analytics.MessagesTotal
(*analytics).MessagesTotal
```

What bothers me, is that the first one - does not look to be using pointers at all!

Something I forgot about functions in #golang is the concept of function receivers. Due to the lack of OOP - they are the way to attach methods to structs. There are two ways to make the association - by using pointer receivers and by using non-pointer receivers. 

Here is the example of how to use a pointer receiver,
```go
type car struct {
	color string
}

func (c *car) setColor(color string) {
	c.color = color
}

func main() {
	c := car{
		color: "white",
	}
	c.setColor("blue")
	fmt.Println(c.color)
	// prints "blue"
}
```

And here is how to use a non-function receiver,
```go
type car struct {
	color string
}

func (c car) setColor(color string) {
	c.color = color
}

func main() {
	c := car{
		color: "white",
	}
	c.setColor("blue")
	fmt.Println(c.color)
	// prints "white"
}
```

Both of them have access to the original struct. But it's only using the pointer receiver can you mutate the value of the struct. 

