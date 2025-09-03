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

Going to start the next lesson about errors. 

The language has a built-in error interface. It looks like this,

```go
type error interface {
    Error() string
}
```

When something can go wrong in a function, that function should return `error` as its last return value. Any code that calls a function that can return an error should handle errors by testing whether the error is `nil`. 

Also, just realised that #golang has `nil` . 

Here is the solution I wrote to a puzzle,
```go
func sendSMSToCouple(msgToCustomer, msgToSpouse string) (int, error) {
	var costToCustomer, costForSpouse int
	var err error
	costToCustomer, err = sendSMS(msgToCustomer)
	if err != nil {
		return 0, err
	}
	costForSpouse, err = sendSMS(msgToSpouse)
	if err != nil {
		return 0, err
	}
	return costToCustomer + costForSpouse, nil
}
```

For some odd reason, I find it weird that the accepted pattern does not involve calling `err.Error()` . 🤷‍♂️

Here is some example code of a custom error struct,
```go
type userError struct {
    name string
}

func (e userError) Error() string {
    return fmt.Sprintf("%v has a problem with their account", e.name)
}
```

and here is it's usage,
```go
func sendSMS(msg, userName string) error {
    if !canSendToUser(userName) {
        return userError{name: userName}
    }
    ...
}
```

I find the creation of the struct = `userError{name: userName}` to be *fascinating*. If this were python, to create a dictionary this way, I'd need to use quotes around the key. 

One takeaway for me is that #golang does not have error handling. There seems to be a convention on how to deal with them - but there is nothing the language provides to assist. 

So, it is kindof a surprise to me to see that the language comes with an `errors` package. Like this,

```go
var err error = errors.New("something went wrong")
```

I must say, I like the fact that the walrus operator saves me the trouble of defining variable types. 

This is interesting - there exists a `fmt.Errorf()` print method that wraps an error with some additional context. 

There is some stuff here about `panic` and `defer` . My takeaway is that these should be avoided unless I know what I'm doing. 

The code block about defer,
```go
func enrichUser(userID string) User {
    user, err := getUser(userID)
    if err != nil {
        panic(err)
    }
    return user
}

func main() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("recovered from panic:", r)
        }
    }()

    // this panics, but the defer/recover block catches it
    // a truly astonishingly bad way to handle errors
    enrichUser("123")
}
```

feels weird. Mostly because I do not see the defer creating a block of code around the function that will raise the `panic` . Black magic? 🤷‍♂️

Important thing about `panic` = when a function calls `panic` , the program crashes and prints a stack trace.

NOTE: There exists a `log.Fatal` - another approach to dealing with unrecoverable situations. 

