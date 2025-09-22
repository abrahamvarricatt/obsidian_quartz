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

Beginning the chapter on mutexes. 

mutexes come from the `sync` standard library. Here is a struct with them,

```go
import (
	"sync"
	"time"
)

type safeCounter struct {
	counts map[string]int
	mu     *sync.Mutex
}

func (sc safeCounter) inc(key string) {
	sc.mu.Lock()
	defer sc.mu.Unlock()
	sc.slowIncrement(key)
}

func (sc safeCounter) val(key string) int {
	sc.mu.Lock()
	defer sc.mu.Unlock()
	return sc.slowVal(key)
}
```

above shows example of using `Lock()` and `Unlock()` . 

I have to say, this mutex stuff is making my head spin. 

.. that was a short chapter. I am left feeling dissatisffied. 


