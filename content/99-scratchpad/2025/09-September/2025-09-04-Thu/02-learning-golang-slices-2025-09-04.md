---
tags:
  - golang
  - boot-dot-dev
created: 2025-09-04
modified: []
title: ""
---
###### References


---
# Introduction

Starting the section called slices. This looks to be a long one. I wonder why do they use that name? How are slices different from arrays?

At first glance, slicing looks very similar to how things are done in python,
```go
primes := [6]int{2, 3, 5, 7, 11, 13}
mySlice := primes[1:4]
// mySlice = {3, 5, 7}
```

The way slices are explained - they are a view into an array. That is technically accurate, but I found it a bit misleading. At least for me, I got the impression that before creating a slice, we would need to create the backing array - turns out, this is not necessary (we *could* do things that way too!). 

I think slices in #golang are the equivalent of collections in other languages. They are different in the sense that everything in a slice _must_ be part of a continuous memory segment. Internally, that is handled by the language and not something a developer would usually need to worry about.  

One thing that I found a bit surprising - a function that has access to a slice, *can* modify the underlying array. This means that if you pass a slice around, it can be mutated by the callers. 

If we want to create a slice without dealing with the underlying array, we can use the `make` keyword,
```go
// func make([]T, len, cap) []T
mySlice := make([]int, 5, 10)

// the capacity argument is usually omitted and defaults to the length
mySlice := make([]int, 5)
```

I think we pass along 3 arguments to make,
1. the type of array to use
2. the length of the slice we are interested in
3. the total capacity of the underlying array

NOTE: slices created with `make` will be filled with zero value of the type.


Here is how to create a slice with a specific set of values,
```go
mySlice := []string{"I", "love", "go"}
```

The capacity of a slice is the number of elements in the underlying array, counting from the first element in the slice. We use the `cap()` method to figure it out. This should not be needed unless you are optimising on memory. 

 There is a `...` syntax in #golang . It helps define an arbitrary number of arguments into a function. These are called variadic functions and receive the argument as a slice. Some code examples,
 ```go
 func concat(strs ...string) string {
    final := ""
    // strs is just a slice of strings
    for i := 0; i < len(strs); i++ {
        final += strs[i]
    }
    return final
}

func main() {
    final := concat("Hello ", "there ", "friend!")
    fmt.Println(final)
    // Output: Hello there friend!
}
 ```

I just realised that the function `Println` actually returns a value. Here is it's signature,
```go
func Println(a ...interface{}) (n int, err error)
```

We can use the `...` as the spread operator to pass a slice into a variadic function.. Here is example code,

```go
func printStrings(strings ...string) {
	for i := 0; i < len(strings); i++ {
		fmt.Println(strings[i])
	}
}

func main() {
    names := []string{"bob", "sue", "alice"}
    printStrings(names...)
}
```

There is a build-in function named `append` which is used to dynamically add elements to a slice. 

If we want to define a generic slice, we need to do something like this,
```go
result := []float64{}  // the {} at the end are important!
```

Thank God! #golang gives some syntactic sugar to iterate over a slice. The format looks like this,
```go
for INDEX, ELEMENT := range SLICE {
}
```
NOTE: `ELEMENT` is a copy of the value at that index!

Here is some example code for the same,
```go
fruits := []string{"apple", "banana", "grape"}
for i, fruit := range fruits {
    fmt.Println(i, fruit)
}
// 0 apple
// 1 banana
// 2 grape
```

Got a puzzle and here is my solution,
```go
func createMatrix(rows, cols int) [][]int {
	result := [][]int{}
	for i:=0; i<rows; i++ {
		currentCol := make([]int, cols)
		for j:=0; j<cols; j++ {
			currentCol[j] = j*i
		}
		result = append(result, currentCol)
	}
	return result
}
```

it works. And here is the pre-made solution,
```go
func createMatrix(rows, cols int) [][]int {
	matrix := make([][]int, rows)
	for i := 0; i < rows; i++ {
		matrix[i] = make([]int, cols)
		for j := 0; j < cols; j++ {
			matrix[i][j] = i * j
		}
	}
	return matrix
}
```

Ohh!! Now I understand why my original code did not work. `make` always operates on 1D arrays. We can build larger, - but it's on us to fill it as needed. `make` will not create randomly sized matrixes. 

There is an interesting gotcha with `append()`. If we are not careful, we might end up making assignments to the wrong array. Do NOT do this,
```go
// dont do this!
someSlice = append(otherSlice, element)
```



