---
tags:
  - boot-dot-dev
  - golang
created: 2025-09-15
modified: []
title: ""
---
###### References


---
# Introduction

Starting the segment about packages and modules now. 

A directory of #golang code can have at most one package. All `.go` files in a single directory must all belong to the same package. If they don't, an error will be thrown by the compiler. This is true for main and library packages alike. 

This is new. This next lesson requires me to run #golang on my local box. They suggest installing go version `1.25` and I could do that - but instead, I'm going to install the goenv tool and use it to manage different versions. 

Here are installation steps,

https://github.com/go-nv/goenv/blob/master/INSTALL.md

it is very similar to pyenv. 

Decided to default with `1.25.1` . 

Next, I need to install the Boot.dev CLI tool. Here is what they want me to run,
```
go install github.com/bootdotdev/bootdev@latest
```

which seems to install `bootdev` in my Go Toolchain's `bin` directory. I do not like it - but meh. 🤷‍♂️

In a new terminal, this command seems to work,
```
$ bootdev --version
bootdev version v1.20.3
```

Next I need to authenticate. This is the command to start things,
```
$ bootdev login
```

That opened a browser session, saw that I was logged in and re-used that session. Will try the next exercise now. 

Created a new folder and a go module using,
```
$ go mod init example.com/abrahamv/hellogo
go: creating new go.mod: module example.com/abrahamv/hellogo
```

We can create binary files using `go build` and we can install them using `go install` . 

This should install binaries inside a `GOBIN` somewhere. On my box, I need to open a new terminal to get that auto-detected. Not a big deal. 


Finished the lesson ... this is different from other languages. I need more practise with it. 


