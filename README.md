# GoMaterials

A collection of things, links and howtos to get up to speed and avoid the
beginner- and intermediate-level gotchas that almost everyone falls into.

- [GoMaterials](#gomaterials)
	- [Setting up Go Dev Environment](#setting-up-go-dev-environment)
	- [First Steps](#first-steps)
	- [The Tour](#the-tour)
	- [Some things to watch out for](#some-things-to-watch-out-for)
		- ["Reference Types"](#reference-types)
		- [Scope Shadowing](#scope-shadowing)
			- [Always break down long functions into smaller pieces](#always-break-down-long-functions-into-smaller-pieces)
		- [Newbies and Architecture](#newbies-and-architecture)
		- [Channels and Goroutines](#channels-and-goroutines)
			- [Selectors are random](#selectors-are-random)
			- [Unbuffered channels block](#unbuffered-channels-block)
			- [Set up the receiver first, before trying to send to it](#set-up-the-receiver-first-before-trying-to-send-to-it)
	- [Going Deeper](#going-deeper)
		- [The Greats](#the-greats)

## Setting up Go Dev Environment

[Installation and Environment Setup](basics/installation.md) - Recommended
method from binary package

## First Steps

Go is a language that has a deliberately tiny core and small number of keywords
and basic types in order to allow developers to rapidly get started with it.

If you have programmed in almost any curly brackets language, the only thing
that will stumble you at first is the 'backwards' type signatures. Once you get
used to them the rest of the languages will seem backwards.

## The Tour

The [tour](https://go.dev/tour) is a good basic starting point to quickly cover
the basics of all of the important points about packages, imports, all of the
main structure and syntactic elements.

## Some things to watch out for

Go has some odd quirks here and there that most beginners end up falling over
quite a lot, so first a little summary of the items that will get you into
trouble in the early days.

### "Reference Types"

The Slice (dynamic array) and Map types appear to be values, but they are not,
rather, they behave like pointers that you don't have to get pointers to with
the prefixes `&` and dereference with `*`.

The reason why this is important is that concurrent goroutines can modify them
while others are reading them, leading to race conditions that won't be detected
without the race detector turned on, and can lead to mysterious bugs of
concurrency.

### Scope Shadowing

This is where two identically named variables, perhaps identical typed
variables, can be used within a scope that unless your code editor highlights
their distinctiveness through different colours, you can mistake for each other
in particularly long sections with multiple layers of depth of if, for, switch
or select blocks without realising it, and then wonder why the value in one
place seems to differ from another.

The best advice that can be given regarding this is:

#### Always break down long functions into smaller pieces

### Newbies and Architecture

A common way of working in Go is very much ad-hoc, by-the-seat-of-the-pants -
that is, you just start writing your main, and then after it fills a page, start
breaking its elements out of the main and put them into functions with a logical
name, then usually, once you start to see structured types recurring, define a
formal type, possibly create a new package for it, and then isolate this
functionality in an independent package.

Of course, such an approach to writing code has some limitations, and after you
have written a few small applications you will start to think more in terms of a
modular structure, tying together code related to a common functionality to a
structure that stores data relevant to that functionality.

### Channels and Goroutines

For most beginner Go programmers, once they get familiar with how to spawn
goroutines and use channels, there can be a tendency to go a bit mad with it,
and make all kinds of errors.

#### Selectors are random

When execution arrives at a `select` statement, and more than one of the cases
has a channel ready to unload, essentially the Go runtime flips a coin to pick
which one will run first.

Even relatively advanced Go programmers don't seem to understand that this can
be easily worked around by separating the cases into separate select blocks and
thus prioritise one or more of the cases by priority and order.

Further, if need be, for unbuffered or single item buffered channels, one can '
peek' the channel, and then decide to defer it by pushing the item back into the
channel, in the case of a single buffer.

It is absolutely not true that Go does not let you work around this necessary
randomness in select statements.

#### Unbuffered channels block

When you don't specify a number of buffers in the `make` statement for a
channel, by default this means no buffers.

- what this means in practise is that the code will stop execution if it
  attempts to receive, and will wait forever until another goroutine sends on
  this channel.

Thus, there is a key rule to understand about channels:

#### Set up the receiver first, before trying to send to it

If you ignore this rule, you can write code that will try to send, and the
unbuffered channel will block execution of the subsequent receive.

- In the case of a single buffer, this allows you to use a channel within a
  single goroutine.

- In the case of two separate goroutines (such as the main, and a goroutine)
  you must spawn the goroutine with the receiver **before** you attempt to send
  anything to it.

## Going Deeper

In general, once you have done all the previous things and made a few little
programs, there is two things that you do with Go, reading blogs from the great
names in the field, and searching github for packages that do things.

### The Greats

- #### (The Go Blog)[https://go.dev/blog/]

  Several of the Go Authors and other Google folk post articles on this blog.
  Rob Pike, Russ Cox, Ian Lance Taylor, Robert Griesemer, Ken Thompson.

- #### (Dave Cheney)[https://dave.cheney.net/]
