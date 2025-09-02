---
tags:
  - golang
  - boot-dot-dev
created: 2025-09-02
modified: 
title: ""
---
###### References


---
# Introduction

Beginning the section on interfaces now. 

`interfaces` are collections of methods. A type implements an interface if it has methods that match the interface's method signatures. 

Here is example code,
```go
type shape interface {
  area() float64
  perimeter() float64
}

type rect struct {
    width, height float64
}
func (r rect) area() float64 {
    return r.width * r.height
}
func (r rect) perimeter() float64 {
    return 2*r.width + 2*r.height
}

type circle struct {
    radius float64
}
func (c circle) area() float64 {
    return math.Pi * c.radius * c.radius
}
func (c circle) perimeter() float64 {
    return 2 * math.Pi * c.radius
}
```

In the above, we have an interface named `shape`. Both the structures `rect` and `circle` implement this interface - but it is interesting to note that there is (as far as I can tell), no direct connection between the struct and the interface (unlike inheritance in other languages). In fact, things are still valid without mentioning the interface in the code! eg,
```go
type rect struct {
    width, height float64
}
func (r rect) area() float64 {
    return r.width * r.height
}
func (r rect) perimeter() float64 {
    return 2*r.width + 2*r.height
}
```

Assuming that a struct implements an interface it means that it can be used as that interface type. Here is some code example,
```go
func printShapeData(s shape) {
	fmt.Printf("Area: %v - Perimeter: %v\n", s.area(), s.perimeter())
}
```

This approach makes it a bit convoluted to check if a struct implements a particular interface - since there is not explicit association. 

One way to check is to declare a function that takes the interface as an argument and see if the struct can be passed to it. Basically, ask the compiler. That feels sad. I feel like an IDE should be able to tell me as well. 

Here is an interesting thing. named parameters are optional. Where it comes into play with interfaces is trying to understand what an interface is doing. 

For example, this is valid,
```go
type Copier interface {
  Copy(string, string) int
}
```

The above is also very confusing. Here is the same thing, but with some description,
```go
type Copier interface {
  Copy(sourceFile string, destinationFile string) (bytesCopied int)
}
```

I like the second one better. For some reason the braces `()` around the return int feel weird. 🤷‍♂️

This might be the first example I've seen of type checking,
```go
type shape interface {
	area() float64
}

type circle struct {
	radius float64
}

// s is an object implementing shape interface

c, ok := s.(circle)
if !ok {
	// log an error if s isn't a circle
	log.Fatal("s is not a circle")
}

radius := c.radius
```

If I follow the code correctly, this part,
```go
c,ok := s.(circle)
```

is what does the type checking. Yuck. I miss python's way of doing things!

so we can use switch statements to do type checks too. Code,

```go
func printNumericValue(num interface{}) {
	switch v := num.(type) {
	case int:
		fmt.Printf("%T\n", v)
	case string:
		fmt.Printf("%T\n", v)
	default:
		fmt.Printf("%T\n", v)
	}
}

func main() {
	printNumericValue(1)
	// prints "int"

	printNumericValue("1")
	// prints "string"

	printNumericValue(struct{}{})
	// prints "struct {}"
}
```

This is new = `fmt.Printf("%T\n", v)` the `%T` means that we print the type of a variable. 

This is interesting. You can define sub-interfaces (or embedded interfaces?). Example,
```go
type car interface {
	Color() string
	Speed() int
}
type firetruck interface {
	car
	HoseLength() int
}
```

In the above, `firetruck` expects the `car` interface to be defined and has something extra on top. 

All this about interfaces makes me feel that it is a dense topic. Something to understand better with practice. 

