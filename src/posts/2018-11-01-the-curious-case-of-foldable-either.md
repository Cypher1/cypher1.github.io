<!--
published: false
title: The curious case of Either's Foldable instance
category: [Haskell, Types, Debugging]
excerpt: |
    TODO
feature_text: |
    **Some fun with Polymorphism**
feature_image: "/assets/imgs/koz1.JPG"
image: "/assets/imgs/koz1.JPG"
-->

I recently wrote something like the following **Haskell**:
```haskell
divOrFail :: Either Int String -> Int -> Either Int String
divOrFail (Left d) n
  | n==0 = Right ("Cannot divide by 0")
  | (d`mod`n)/=0 = Right ("Cannot divide "++show d++" by "++show n)
  | otherwise = Left $ d`div`n
divOrFail (Right e) _ = (Right e)

applyAll :: Foldable f => (Either a err -> b -> Either a err) -> a -> f b -> Either a err
applyAll func start xs = foldl func (Left start) xs
```

The original was a bit more complicated but this preserves the bug in the original.
So lets break this down a bit (or [skip it](#the-catch) if you like).

Lets start with the more complicated part. In particular this type signature:
```haskell
applyAll :: Foldable f => (Either a err -> b -> Either a err) -> a -> f b -> Either a err
```

So, first ignore the type constraints (the `Foldable f =>` bit) we can come back to it.
Our arguments are:
- a function that takes something of type `b` and either an `a` value or an error,
- a start value
- a thing holding things of type `b` (looking at the constraint, we can see that the 'bunch' is [foldable](http://hackage.haskell.org/package/base-4.12.0.0/docs/Data-Foldable.html#t:Foldable) which lets us do some neat stuff on it).

`applyAll` then uses `foldl` to repeatedly apply a function on a value (or an error), accumulating the result.

```haskell
applyAll func start xs = foldl func (Left start) xs
```

So, that was all 'simple'. What could go wrong? <sub>/s</sub>


The other part of the code snippet is fairly straightforward:
```haskell
divOrFail :: Int -> Either Int String -> Either Int String
```

This is a function that takes two things:
- an `Int`
- something that is either an `Int` or a `String`

```haskell
divOrFail n (Left d)
  | n==0 = Right ("div by 0")
  | (d`mod`n)/=0 = Right ("Cannot divide "++show d++" by "++show n)
  | otherwise = Left $ d`div`n
```

When the 'something' is an `Int` that is a multiple of **n** we divide it by **n** and return the result.
If it is not divisible, we return a 'Right' containing an error message of the form (e.g. 'Cannot divide 3 by 2') which tells the user that the number wasn't able to be divided.

`
divOrFail _ (Right e) = (Right e)
`
When the 'something' is a string, we return the string (e.g. an error message).


This allows me to write things like:

```haskell
> applyAll divOrFail 120 [1,2,3]
Left 20
> 1*2*3*20 == 120
True
```
```haskell
> applyAll divOrFail 13 [3,0,1]
Right "Cannot divide by 0"
```
```haskell
> applyAll divOrFail 12 [3,4,2]
Right "Cannot divide 1 by 2"
```

Hopefully it's clear now that this could be handy (even though it is just a toy example).


# The catch

So, this is pretty good, right?

Well, not quite. See, I made a simple (foolish) mistake when I used this function.

Unfortunately I didn't write:
```haskell
applyAll divOrFail 13 [3,0,1]
```

I wrote:
```haskell
applyAll divOrFail 13 (Left [3,0,1])
```

Now this seems like it will error as `Either [Int] b` is a different type to `[Int]`, but it doesn't.
Let's check the types involved in `ghci`:

```haskell
> :t [3,0,1]
[3,0,1] :: Num a => [a]

> :t Left [3,0,1]
Left [3,0,1] :: Num a => Either [a] b
```

So, we might have expected the types `[a]` and `Either [a] b` to be too different to fit in the same 'hole' (I did when I first found my bug).

But what does `ghci` say when I ask for the type (without the problematic argument)?
```haskell
> :t applyAll divOrFail 13
applyAll divOrFail 13 :: Foldable f => f Int -> Either Int String
```

I'd never restricted the type to a list making `applyAll divOrFail` a polymorphic function.
In fact, `applyAll divOrFail` could take any `foldable` over `Int`s.
A lot of different data types implement `Foldable`, most of the 'container' types (e.g. `List`, `Set`, `Map`) have a `Foldable` instance. So this tells us that `Either [a]` has a `Foldable` instance. A quick search on the **Haskell** function search tool ['hoogle'](https://www.haskell.org/hoogle/?hoogle=Foldable) finds the package `Data.Foldable` and [tada](http://hackage.haskell.org/package/base-4.12.0.0/docs/src/Data.Foldable.html#line-326when).

We can now have a look at `Either`'s `Foldable` instance, specifically, the `foldr` implementation (it's `foldl` is implemented using `foldr`).

```haskell
foldr _ z (Left _) = z
foldr f z (Right y) = f y z
```

We're passing in a `Left` in this case, so we can just look at that first line which takes 'something', `z` and a `Left` and returns `z`. It clearly is ignoring the value inside the `Left`!

Looking at the second line, as can see that it is the `Right` side of the either that the `foldr` is running the function on.

We can see a similar thing looking at the types.

In fact, if we think a bit more about the type `Either a b` it makes sense that the `f` in our `applyAll` function isn't being matched by `Either`, it's being matched by `Either a`. This means that the 'contents' of our polymorphic type, `f`, is `b`, not `a`.


**TLDR**: I had the arguments to `Either` around the wrong way and `Either err` acts as if it were a list of 0 or 1 elements.

[Here's the code from above](../code/foldable_either.hs)
