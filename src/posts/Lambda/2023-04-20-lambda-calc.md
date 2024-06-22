<!--
published: false
title: Lambda Calculus: Building little languages
category: [Programming, Languages, Lambda Calculus, IR]
excerpt: |
feature_text: |
  **I believe in the separation of Church and State **
feature_image: "/assets/imgs/koz3.JPG"
image: "/assets/imgs/koz3.JPG"
-->

# WIP - Work in progress

The following post is a work in progress, but I thought I'd keep uploading it as a way to push myself to finish it sooner rather than later.

# Lambda Calculus: Building little languages

In my work I have had several opportunities to build tooling for other developers.
Specifically these have been tools for assembling apps, programs and infrastructure using a high level language.

These have mostly been experimental, either exploring the benefits of different compiler architectures, approaches to optimisation or programming paradigms.

So, I've been stuck with a question:

> How do we build a programming language from the smallest number of the simplest parts possible?

Many approaches have been taken to building programming languages and compilers, and there are almost as many approaches to doing so.

## A small family tree of programming language models

<div class="center">

```dot process Languages by style and paradigm
digraph {
    conf [label="configuration languages"]
    clike [label="C-like languages"]
    Cpp [label="C++"]
    incomplete [label="Turing Incomplete\n(finite time execution)"]
    complete [label="Turing Complete\n(unknown time execution)"]
    HighLevelLangs [label="High level languages"]
    Fsharp [label="F#"]
    Csharp [label="C#"]

    incomplete -> conf
    incomplete -> data
    incomplete -> build

    data -> JSON
    data -> INI

    conf -> YAML
    conf -> INI
    conf -> JSON
    conf -> Toml
    conf -> Starlark

    build -> Starlark
    build -> Meson

    complete -> HighLevelLangs
    complete -> incomplete

    HighLevelLangs -> functional
    HighLevelLangs -> procedural
    HighLevelLangs -> "object oriented"

    procedural -> Fortran
    procedural -> clike
    procedural -> Fsharp

    "object oriented" -> Java
    "object oriented" -> Python
    "object oriented" -> Cpp
    "object oriented" -> Csharp
    "object oriented" -> OCaml
    "object oriented" -> erlang

    clike -> C
    clike -> Csharp
    clike -> Cpp
    clike -> Rust
    clike -> Zig
    clike -> Go
    clike -> JavaScript
    clike -> TypeScript
    clike -> Kotlin

    procedural -> Python
    procedural -> Starlark
    procedural -> commandline

    commandline -> sh
    commandline -> zsh
    commandline -> fsh
    commandline -> bash
    commandline -> perl

    functional -> Haskell
    functional -> Lisp
    functional -> Fsharp
    functional -> OCaml
}
```

```dot process Languages by runtime
digraph {
    Fsharp [label="F#"]
    Cpp [label="C++"]
    Csharp [label="C#"]
    dotNET [label=".NET (MSIL/CIL)"]
    LLVMIR [label="LLVM IR"]
    browser [label="Browser IR"]
    run [color=red]

    browser -> run [label="browser", color=red]
    JVM -> run [label="java", color=red]
    dotNET -> run [label="CLR", color=red]
    dotNET -> binary [label="coreRT"]
    LLVMIR -> run [label="llvm jit", color=red]
    LLVMIR -> assembly [label="llc"]
    assembly -> binary [label="assembler&linker"]
    binary -> run [label="exec", color=red]
    LLVMIR -> WASM [label="llvm"]

    Java -> JVM [label="javac"]
    Kotlin -> JVM [label="kotlinc"]
    OCaml -> JVM [label="ocamlc"]

    Csharp -> dotNET [label="visual studio!?"]
    Fsharp -> dotNET [label="fsc"]

    C -> assembly [label="gcc"]
    erlang -> binary [label="erlc"]
    Cpp -> assembly [label="g++"]
    Go -> binary [label="go"]
    Fortran -> binary [label="gfortran\nifort\npgf77"]
    Kotlin -> LLVMIR [label="kotlinc", color=blue]
    C -> Zig [label="zig", color=blue]
    Cpp -> Zig [label="zig", color=blue]
    Zig -> binary [label="zig"]
    Zig -> LLVMIR [label="zig", color=blue]
    Cpp -> LLVMIR [label="clang"]
    C -> LLVMIR [label="clang"]
    Rust -> LLVMIR [label="rustc"]
    Haskell -> STG -> Cmm [label="ghc"]
    Cmm -> binary [label="ghc", color=blue]
    Cmm -> LLVMIR [label="ghc", color=blue]
    Cmm -> C [label="ghc"]
    JavaScript -> browser [label="v8 and co"]
    JavaScript -> C [label="shermes", color=blue]
    JavaScript -> TypeScript [label="shermes", color=blue]
    TypeScript -> JavaScript [label="tsc"]
    Kotlin -> JavaScript [label="kotlinc", color=blue]
    WASM -> browser [label="v8 and co"]
    Lisp -> run [label="lisp", color=red]
    sh -> run [label="sh", color=red]
    zsh -> run [label="zsh", color=red]
    fsh -> run [label="fsh", color=red]
    bash -> run [label="bash", color=red]
    perl -> run [label="perl", color=red]
    Python -> run [label="cpython", color=red]
}
```

</div>



## My favourite approach: Lambda Calculus

My favourite class of approaches is to build a small core language and build everything on top of that. This has a few benefits that I hope to detail here.

## TODO: Finish

```rust,no_run
{{#rustdoc_include p1.rs:definition}}
```

```rust,no_run
{{#rustdoc_include p1.rs:helpers}}
```

```rust
{{#rustdoc_include p1.rs:demo1}}
```

<center>

Fin

</center>

-----

Here's the full code for you to experiment with:

```rust,editable
{{#rustdoc_include p1.rs:all}}
```