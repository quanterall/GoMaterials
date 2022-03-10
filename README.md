# GoMaterials

A collection of things, links and howtos to get up to speed and avoid the
beginner- and intermediate-level gotchas that almost everyone falls into.

- [GoMaterials](#gomaterials)
	- [About Go](#about-go)
	- [Setting up Go Dev Environment](#setting-up-go-dev-environment)
	- [Compilation](#compilation)
	- [First Steps](#first-steps)
	- [The Tour](#the-tour)
	- [Traps for Newly Minted Gophers](#traps-for-newly-minted-gophers)
		- ["Reference Types"](#reference-types)
		- [Scope Shadowing](#scope-shadowing)
		- [Architecture](#architecture)
			- [Packages](#packages)
			- [Modules](#modules)
		- [Channels and Goroutines](#channels-and-goroutines)
			- [Selectors are random](#selectors-are-random)
			- [Unbuffered channels block](#unbuffered-channels-block)
			- [Set up the receiver first, before trying to send to it](#set-up-the-receiver-first-before-trying-to-send-to-it)
	- [Tutorials](#tutorials)
		- [Official Go Tutorials and Docs](#official-go-tutorials-and-docs)
		- [The Kitchen sink: Human Readable Binary Transcription Codec with Microservice](#the-kitchen-sink-human-readable-binary-transcription-codec-with-microservice)
	- [Going Deeper](#going-deeper)
		- [General Resources](#general-resources)
			- [https://go.dev](#httpsgodev)
			- [https://pkg.go.dev/ (formerly known as godoc)](#httpspkggodev-formerly-known-as-godoc)
			- [https://en.wikipedia.org/wiki/Go_(programming_language))](#httpsenwikipediaorgwikigoprogramminglanguage)
			- [https://github.com/avelino/awesome-go](#httpsgithubcomavelinoawesome-go)
		- [The Greats](#the-greats)
			- [The Go Blog](#the-go-blog)
			- [Dave Cheney](#dave-cheney)

## About Go

Go is a programming language that was originally developed within Google by Ken
Thompson, Rob Pike and Robert Griesemer, as a way to both reduce the amount of
resources and time wasted by C++ compilation, and as a means to more rapidly
inducting new developers into back-end systems programming.

As such, Go has a very minimal set of reserved words, and relatively speaking, a
quite small standard library.

Go is a great language to start with as a new developer because there is so
little, and so little that isn't essential, to learn, in order to use the
language.

It has some minor downsides, the worst one being its 'toy' reputation, in part
justified by 'serious' programmers by the existence of a Garbage Collector.

However, practically the entire internet depends on applications that are
written in Go, namely Docker, Kubernetes, and within the Open Source Unix
command line environment, a growing number of very useful tools are making it
into base installations of linux.

The only real caveats for systems programming with Go come from the goroutine
scheduling system, which sometimes has to be manually overridden for specific
types of tasks, in very large applications there can be memory management
issues, which can be often fixed by tuning the GC's threshold for activation,
and it is pretty much useless for emebedded systems, kernels, and *binary* GUI
applicaitons (although Gio and Nucular are becoming reasonably usable now).

It is especially suitable for writing peer to peer applications, hence the
primary implementation of IPFS is in Go, also, as is the first language of the
libp2p library that spawned out of the IPFS project.

## Setting up Go Dev Environment

[Installation and Environment Setup](basics/installation.md) - Recommended
method from binary package

## Compilation

Go's most famous and convenient feature is its lightning fast compilation 
system. Go compiles everything into a caching system, and never does any 
work that doesn't need to be done, unless you specify to repeat this process 
with `-a`. 

The `go` command has three main variants, `build`, `install` and `run`. 
Build will pop out a binary in the current directory, install does the same 
but places it wherever you have defined the environment variable `GOBIN` to 
refer to, in the installation guide this is `$HOME/bin` and `run` plops it 
into a temporary cache location and runs it from there, and with small apps 
or small non-cascading changes, it can seem almost as fast as interpreted 
language execution, except binary thereafter.

## First Steps

Go is a language that has a deliberately tiny core and small number of keywords
and basic types in order to allow developers to rapidly get started with it.

If you have programmed in almost any curly brackets language, the only thing
that will stumble you at first is the 'backwards' type signatures. Once you get
used to them the rest of the languages will seem backwards.

## The Tour

The [tour](https://go.dev/tour) is a good basic starting point to quickly cover
the basics of all of the important points about packages, imports, all of the
main structure and syntactic elements. The tour is where most people start when
they already know another curly bracket language.

## Traps for Newly Minted Gophers

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

**Always break down long functions into smaller pieces**

### Architecture

A common way of working in Go is very much ad-hoc, by-the-seat-of-the-pants -
that is, you just start writing your main, and then after it fills a page, start
breaking its elements out of the main and put them into functions with a logical
name, then usually, once you start to see structured types recurring, define a
formal type, possibly create a new package for it, and then isolate this
functionality in an independent package.

This is an approach to programming that is not so easy in some languages,
usually more associated with educational or interpreted languages like Pascal or
Python. But you can really write serious software, at least at the beginning
stages, in this way, and through it develop an intuitive feel for how to
structure code that can get you almost to the finish line, unlike almost no
other language.

Of course, such an approach to writing code has some limitations, and after you
have written a few small applications you will start to think more in terms of a
modular structure, tying together code related to a common functionality to a
structure that stores data relevant to that functionality.

#### Packages

Rather than leaving it up to people to complicate things, the Go authors 
from the first day used a notion called a `package`, which is much the same 
as what you find in the languages Modula 1 and 2, and Oberon 1 and 2.

For those of you coming from Rust or other languages with built-in package 
management systems, you may be used to this being some special name you have 
to register somewhere.

In Go, it is the URL of the git hosting repository, without all the extra 
bits that a web server or Git client needs, eg `github.com/golang/go`. In 
the olden days, before Git became the de facto industry standard, it was 
Mercurial. 

In Go, a package is simply the collection of files in one folder that are 
mashed together by the compiler's preprocessing pass to become one effective 
single file that is then compiled by the compiler engine.

Go's package management system, and the modules (see in the following 
section), this is completely decentralised and ad-hoc, if Git can resolve 
the URL by adding .git to the end of the package name, and `http://` or 
`https://` then it fetches the contents of this folder into a cache and adds 
it to the compilation job.

#### Modules

Since the arrival of the Go Modules system, it has become a lot easier to
reliably build Go applications.

Once upon a time, Go did not have a strict system for checkpointing and
specifying the exact version of a package that was required. Sometimes 
repositories would fall offline or versions would break APIs and it started 
to become problematic and back in 2018, modules were introduced, and they 
became mature in 2019.

Most of the time, if you bump into old packages (the Go word for a library, 
but concretely specifying one folder containing one or more Go source files),
you can often make them work with 'go mod init' and the build system will 
sync from the URL, if it is within old GOPATH structure, or will ask you to 
specify the source of a new initialized module.

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

This is partly related to a notion that you will read a lot in Go programming
blogs called "idiom". In general, it's best to stick to idiom, but if you have a
need to prioritise handling signals from channels, you can add further layers of
structure to the select blocks and not just lump them all together just because
many times this is how it is done.

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

## Tutorials

### Official Go Tutorials and Docs

[go.dev/doc](https://go.dev/doc/)

### The Kitchen sink: Human Readable Binary Transcription Codec with Microservice

warning: work in progress

[github.com/quanterall/kitchensink](https://github.com/quanterall/kitchensink)

## Going Deeper

In general, once you have done all the previous things and made a few little
programs, there is two things that you do with Go, reading blogs from the great
names in the field, and searching github for packages that do things.

### General Resources

#### [https://go.dev](https://go.dev)

It used to be golang.org but now it's go.dev... This is pretty much the nexus of
everything Go on the internet, and the authoritative location to find binary
releases and pointers to the most old and refined resources relating to the
language.

#### [https://pkg.go.dev/](https://pkg.go.dev/) (formerly known as godoc)

Like most modern languages, Go has an inline source code comment based
documentation system, which is generated via the decentralised networks of Git
repository hosts where Go repositories can be found, and are automatically
generated when you search for them and they haven't yet been aggregated:

#### [https://en.wikipedia.org/wiki/Go_(programming_language)](https://en.wikipedia.org/wiki/Go_(programming_language))

Wikipedia page of course.

#### [https://github.com/avelino/awesome-go](https://github.com/avelino/awesome-go)

The Obligatory Awesome collection (which keeps getting awesomer)

### The Greats

Some of the best info about Go comes from the crazy guys who built the thing in
the first place, as well as the many early adopters who have been blogging about
it since not long after it was released.

#### [The Go Blog](https://go.dev/blog/)

Several of the Go Authors and other Google folk post articles on this blog. Rob
Pike, Russ Cox, Ian Lance Taylor, Robert Griesemer, Ken Thompson.

#### [Dave Cheney](https://dave.cheney.net/category/golang)

Dave is an expert in the implementation and underlying mechanics that go on in
the Go runtime, and you can learn a lot browsing his blog.
