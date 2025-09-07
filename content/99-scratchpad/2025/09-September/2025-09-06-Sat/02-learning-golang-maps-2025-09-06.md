---
tags:
  - golang
  - boot-dot-dev
created: 2025-09-06
modified: []
title: ""
---
###### References


---
# Introduction

Going to start the chapter on Maps. 

Sweet! In #golang maps are similar to Python dictionaries. That is something I can wrap my head around. 😄

There are a couple of ways of making maps. We can use the `make` function,

```go
ages := make(map[string]int)
ages["John"] = 37
ages["Mary"] = 24
ages["Mary"] = 21 // overwrites 24
```

or by using a literal,

```go
ages = map[string]int{
  "John": 37,
  "Mary": 21,
}
```

The `len()` function works on maps. It returns the total number of key/value pairs. 

I was doing a puzzle and all of a sudden, had confusion on how structs were declared. Needed to check back on my notes here = [[04-learning-golang-structs-2025-09-01]] 

Specifically, I was confused on how to create a new struct within a for loop. Here is the solution, 
```go
	result := make(map[string]user)

	for index, value := range names {
		result[value] = user {
			name: names[index], 
			phoneNumber: phoneNumbers[index],
		}
	}
```

Also, if we need to return an `Error()` as part of the return list here is how to declare it inline,
```go
return nil, errors.New("invalid sizes")
```

Here is some interesting stuff. 

```go
// Inserting an element
m[key] = elem

// get an element
elem = m[key]

// delete an element
delete(m, key)

// check if a key exists
elem, ok := m[key]
```

What interests me is that how to check for an element, as well as how to retrieve an element are very similar - if not identical. With the latter just skipping a return value. 

We can have nested maps. Here is one way to define them,
```go
hits := make(map[string]map[string]int)
```

And here is how to reference within it,
```go
n := hits["/doc/"]["au"]
```

The above is cumbersome to deal with. Specifically, we will need to check if the inner map exists and create it if it does not. 

An alternative is to use structs as keys. For example,
```go
type Key struct {
    Path, Country string
}
hits := make(map[Key]int)
```

Here is how to increment data,
```go
hits[Key{"/", "vn"}]++
```

We can combine an `if` statement with an assignment operation to use the variables inside the `if` block. Here is a code example,

```go
names := map[string]int{}
missingNames := []string{}

if _, ok := names["Denna"]; !ok {
    // if the key doesn't exist yet,
    // append the name to the missingNames slice
    missingNames = append(missingNames, "Denna")
}
```

Maps also hold references. Like slices. 

If we pass maps to a function that changes the content of the maps - those changes will be visible to the caller. 

You can, kindof use maps like sets. Specifically, implement a map of type `bool` . Set it to true if the value is part of the set. 

By default, if you try to read the value of a non-existent key, #golang will return the zero value for that data-type. 

Here is how to convert a string into a slice of runes,
```go
runes := []rune(word)
```

Code on how to use a map as a set (or counter),
```go
attended := map[string]struct{}{
    "Ann": {},
    "Joe": {},
    ...
}

if _, ok := attended[person]; ok {
    fmt.Println(person, "was at the meeting")
}
```

Here is my solution to the last puzzle,
```go
package main

import (
	"strings"
)


func countDistinctWords(messages []string) int {
	counters := map[string]struct{}{}
	count := 0

	for _, message := range messages {
		fields := strings.Fields(message)
		
		for _, field := range fields {
			normalized := strings.ToLower(field)
			if _, ok := counters[normalized]; !ok {
				// does not exist
				count++
				// create entry
				counters[normalized] = struct{}{}
			}			
		}
	}

	return count
}

```

And here is the recommended solution,

```go
package main

import (
	"strings"
)

func countDistinctWords(messages []string) int {
	distinctWords := make(map[string]struct{})
	for _, message := range messages {
		for _, word := range strings.Fields(strings.ToLower(message)) {
			// struct{}{} is a zero-byte value in Go.
			distinctWords[word] = struct{}{}
		}
	}
	return len(distinctWords)
}

```

I did not quite realize that `ToLower()` could have worked on the full sentence. And also - there was no need to for me to keep track of a separate count variable as I could have just used `len(map)`. 

