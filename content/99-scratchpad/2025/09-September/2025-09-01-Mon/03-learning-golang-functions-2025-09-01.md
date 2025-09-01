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

And now moving onto functions. 

Something that has felt _weird_ to me in all the examples so far is that when functions are defined in #golang , the type comes _after_ the variable name. This might be the first language where I've seen it implemented that way and it feels ... like the language is trying to be different for the sake of it. Not a fan of that decision. 

To be fair, it seems to be a common pattern in #golang , so with practise, perhaps I'll get used to it?

This is new. If multiple arguments use the same type and are next to each other, the type can be specified at the end. Here is an example,

```go
func addToDatabase(hp, damage int, name string)
```

Ok - that makes the code less verbose. But I think I like the verbosity. Could just be me. 🤷‍♂️

Ah, we are beginning to use unit tests now. Sweet!

Just skimmed over their test code. I can guess some of it - but a lot of it is unknown to me. Will set it aside for now. 

Am not going to read it now, but here is a blog post about Go's declaration syntax,
https://go.dev/blog/declaration-syntax

Oh. #golang has a blank identifier = `_` ref: https://go.dev/doc/effective_go#blank
which is used to explicitly ignore a return value. If this were python, we just won't care about it. I wonder why did they implement things this way?

IIRC, there was some kind of convention in Python around the underscore variable = `_`. But that was a convention and not a language feature. Here in #golang , this is a language thing. 

There is a feature in #golang called "Named return values". It results in code like this,
```go
func getCoords() (x, y int) {
	// x and y are initialized with zero values

	return // automatically returns x and y
}
```

The above return statement does not have any arguments as it's part of the function definition and we're happy with the default values. 

This feels like a convenience thing. Can't quite picture what's so great about it. 🤷‍♂️

Q. What is a guard clause?
A. An early return from a function when a given condition is met. 

The concept of anonymous functions exist here too. 

This is something new. The `defer` keyword. Basically - "do this thing before the current function returns". I like the example they use for this. Here,

```go
func GetUsername(dstName, srcName string) (username string, err error) {
	// Open a connection to a database
	conn, _ := db.Open(srcName)

	// Close the connection *anywhere* the GetUsername function returns
	defer conn.Close()

	username, err = db.FetchUser()
	if err != nil {
		// The defer statement is auto-executed if we return here
		return "", err
	}

	// The defer statement is auto-executed if we return here
	return username, nil
}
```

This is new and different too - block scope. What I find nice is that you can randomly define blocks anywhere. This example snippet shows it off very well,

```go
package main

func main() {
    {
        age := 19
        // this is okay
        fmt.Println(age)
    }

    // this is not okay
    // the age variable is out of scope
    fmt.Println(age)
}
```

I guess this is a natural consequence of scoping. It is possible to have a method access variables outside itself. In a sense, it reminds me of global variables. They are NOT. But they remind me of them. 

A function that references variables outside it's own body is called a `closure`. That is an easy definition and I follow it. I wonder if javascript closures are the same thing? Here is a wikipedia page,

https://en.wikipedia.org/wiki/Closure_(computer_programming)

and I find it too dense. 

Here is the code example of closures,
```go
func concatter() func(string) string {
	doc := ""
	return func(word string) string {
		doc += word + " "
		return doc
	}
}

func main() {
	harryPotterAggregator := concatter()
	harryPotterAggregator("Mr.")
	harryPotterAggregator("and")
	harryPotterAggregator("Mrs.")
	harryPotterAggregator("Dursley")
	harryPotterAggregator("of")
	harryPotterAggregator("number")
	harryPotterAggregator("four,")
	harryPotterAggregator("Privet")

	fmt.Println(harryPotterAggregator("Drive"))
	// Mr. and Mrs. Dursley of number four, Privet Drive
}
```

And now we look into a feature called function currying. I do not quite understand why it even has a name. The example here, 

```go
func main() {
  squareFunc := selfMath(multiply)
  doubleFunc := selfMath(add)

  fmt.Println(squareFunc(5))
  // prints 25

  fmt.Println(doubleFunc(5))
  // prints 10
}

func multiply(x, y int) int {
  return x * y
}

func add(x, y int) int {
  return x + y
}

func selfMath(mathFunc func(int, int) int) func (int) int {
  return func(x int) int {
    return mathFunc(x, x)
  }
}
```

looks like straight-forward application of what we've built so far. Perhaps currying is a kind of pattern?

The puzzle for this section feels mind-bending. More because it's doing something really trivial. For now, I'll just have to remember this as something in my tool-belt and keep an eye out for when to use it. 
