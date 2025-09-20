---
tags:
  - boot-dot-dev
  - golang
created: 2025-09-19
modified: []
title: ""
---
###### References


---
# Introduction

Am going to start the section about channels.

Concurrency is implemented in #golang using coroutines. Or called goroutine . The basic idea seems to be just preface a function call with the keyword `go` . 


channels are a type of thread-safe queue. They allow different goroutines to communicate with each other. 

Here is how to create a channel,
```go
ch := make(chan int)
```

To send data to a channel,
```go
ch <- 69
```
The `<-` operator is called the channel operator. Data flows in the direction of the arrow. The operation will block until another goroutine is ready to receive the value. 

To receive data from a channel,
```go
v := <- ch
```
The above reads and removes a value from a channel and saves it into the variable `v` . This operation will block until there is a value in the channel to be read. 

This exercise was interesting. The code was deadlocking because a method was trying to send a message to a channel which was not being read. It took me a bit of re-reading the code and question to realise that the issue was because the code was NOT spinning up new goroutines. The same method was trying to read back data from the channel - but because code execution is blocked when attempting to send a message - the rest of the code never ran. By using the `go` method to call a function, things worked!

We can blindly read from a channel by using,
```go
<-ch
```

The code will block there until it pops one element off the channel. After that, it resumes operation. 

There is a concept of buffered channels. We can provide a buffer length when creating the channel. It looks like this,

```go
ch := make(chan int, 100)
```

A buffer allows the channel to hold a fixed number of values. This means sending on a buffered channel only blocks when the buffer is full, and receiving blocks only when the buffer is empty. 

Channels can be explicitly closed by a sender;
```go
ch := make(chan int)

// do some stuff with the channel

close(ch)
```

we can use the range function with regard to channels,
```go
for item := range ch {
    // item is the next value received from the channel
}
```

we can use select statement with channels too,
```go
select {
case i, ok := <- chInts:
    fmt.Println(i)
case s, ok := <- chStrings:
    fmt.Println(s)
}
```

We can mark channels are read-only by marking them with `<-chan` here is a code example,
```go
func main() {
    ch := make(chan int)
    readCh(ch)
}

func readCh(ch <-chan int) {
    // ch can only be read from
    // in this function
}
```

And here is how to define write-only channels,
```go
func writeCh(ch chan<- int) {
    // ch can only be written to
    // in this function
}
```

