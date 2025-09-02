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

Moving onto structs now.

Basically a way to collect related data. Here is the example,

```go
type car struct {
	brand      string
	model      string
	doors      int
	mileage    int
}
```

Structs can be nested. Example,
```go
type car struct {
  brand string
  model string
  doors int
  mileage int
  frontWheel wheel
  backWheel wheel
}

type wheel struct {
  radius int
  material string
}
```

What is interesting about the above is that we did not need to define `wheel` before car. Looks like it's fine as long as it's within the same scope?

Something interesting is how to access data in a nested struct. Or I guess, a regular struct - using the dot `.` operator. Example,

```go
myCar := car{}
myCar.frontWheel.radius = 5
```

In the above, I find the default assignment of `car{}` very interesting. I do not think I've seen similar before. 

This is interesting. I cannot convert `string` to `bool` directly in golang. 

This is a weird one. #golang has the concept of anonymous structs. Here is the example they use and IMO, the re-declaration during instantiation looks cumbersome,

```go
type car struct {
  brand string
  model string
  doors int
  mileage int
  // wheel is a field containing an anonymous struct
  wheel struct {
    radius int
    material string
  }
}

var myCar = car{
  brand:   "Rezvani",
  model:   "Vengeance",
  doors:   4,
  mileage: 35000,
  wheel: struct {
    radius   int
    material string
  }{
    radius:   35,
    material: "alloy",
  },
}
```

This is surprising to me - #golang is NOT an object oriented language!

Go has the notion of embedded structs. This is ... a head-scratcher for me. It allows the embedded struct's fields to be accessed at the top level like other fields, instead of via the imported one. This code below demonstrates things,

```go

// some struct definitions
type car struct {
  brand string
  model string
}

type truck struct {
  // "car" is embedded, so the definition of a
  // "truck" now also additionally contains all
  // of the fields of the car struct
  car
  bedSize int
}

// using them,
lanesTruck := truck{
  bedSize: 10,
  car: car{
    brand: "Toyota",
    model: "Tundra",
  },
}

fmt.Println(lanesTruck.brand) // Toyota
fmt.Println(lanesTruck.model) // Tundra

```

My coding instincts tell that this should cause problems. But since it is a part of the language - there must be something I'm not seeing here. 

Oh. When use embedded structs - there is not variable name assigned for the embedded data. So we can't use composition-like access. It makes sense, but I'm not satisfied. 

As if things weren't confusing enough, #golang has the notion of struct methods. These are defined using receivers. Here is some code example,

```go
type rect struct {
  width int
  height int
}

// area has a receiver of (r rect)
// rect is the struct
// r is the placeholder
func (r rect) area() int {
  return r.width * r.height
}

var r = rect{
  width: 5,
  height: 10,
}

fmt.Println(r.area())
// prints 50
```

## Format a string without printing,

Use  `fmt.Sprintf()` to do this. 

A thing about #golang structs is that they are stored as contigous blocks in memory. The can lead to wasted space - but in general usage it should not matter. 

If you want to make it matter, ordering variables from largest to smallest can help. There are packages in go to help figure this out. (not looking them up now!)


There is a thing called "empty structs". Code,
```go

// anonymous empty struct type
empty := struct{}{}

// named empty struct type
type emptyStruct struct{}
empty := emptyStruct{}
```

These are used as unary values. 

This is surprising to me. We need lots of commas when instantiating a struct. 

Just submitted this as part of an exercise,
```go
func (u User) SendMessage(message string, messageLength int) (string, bool) {
	if messageLength <= u.MessageCharLimit {
		return message, true
	}
	return "", false
}

// don't touch below this line

type User struct {
	Name string
	Membership
}

type Membership struct {
	Type             string
	MessageCharLimit int
}
```

The return type definitions in that function ... are something I need to get used to. 

