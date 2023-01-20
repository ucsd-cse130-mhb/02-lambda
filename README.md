# Assignment 2 : Lambda Calculus (200 public points, 300 overall)

For the latest version of this README with any corrections, please visit
[https://github.com/ucsd-cse130-mhb/02-lambda/wiki/README](https://github.com/ucsd-cse130-mhb/02-lambda/wiki/README)

## Working Environment

There are a few different ways that you can work on this assignment.

### GitHub Codespaces

You can set up your development environment using GitHub’s new 
[Codespaces](https://docs.github.com/en/codespaces/overview). 
A Codespace is just like a devcontainer, but instead of running on 
your local machine, it runs in the cloud.

To create a new Codespace, go to the repository created after you 
accept an assignment. Click on the green `<> Code` button and select the 
Codespaces tab. Finally click the green `Create codespace on main` button.

A new tab will open and GitHub will begin building your codespace based 
on the CSE 130 devcontainer. Once it is complete, a web-based VS Code 
interface will display with your repository folder open. Notice there 
is a terminal on the right (or you can open one using the Terminal menu).

Some VS Code extensions are not compatible with the web interface. If 
you would like to open the codespace in the VS Code desktop app, click 
on the green `>< Codespaces` button at the bottom left, and select 
`Open in VS Code` from the pull-down menu that appears at the top.

### Devcontainer

We have created a 
[VS Code Development Container](https://code.visualstudio.com/docs/remote/containers) 
to help bootstrap your Haskell/Elsa development. This is a Docker container 
that is pre-configured with a Haskell environment that you can interact with 
directly from [VS Code](https://code.visualstudio.com/Download).

This requires a bit more setup work and requires having Docker installed and 
running. This method may need further configuration to work on Mac M1s.
Contact us for support if you run into trouble. 

You can download the latest version of the 
[devcontainer here](https://github.com/ucsd-cse130-mhb/cse130-devcontainer/releases/tag/Wi23). 
See the included 
[README](https://github.com/ucsd-cse130-mhb/cse130-devcontainer/blob/main/README.md) 
for installation instructions.

### Working Locally

You can also edit these files and then run them locally on your machine:,

* by running `$ stack exec elsa path/to/file.lc` on a unix machine (with stack installed), OR
* by locally installing `elsa` following [these instructions](https://github.com/ucsd-progsys/elsa#install)

### Web Interface

Finally, a fallback option is to run the assignment files 
through the [web interface](https://goto.ucsd.edu/elsa/index.html).

If you run it online, be sure to **copy back the result** to the corresponding 
local file before committing, pushing, and submitting.


## Submission Instructions

To submit your code, first commit and push your repository to GitHub. 
To see the output of the auto-grader tests, click 'Pull Requests' and 
select Feedback. You can see the output of the tests under the Checks tab.

**When you have completed the assignment, submit your repo to gradescope 
by selecting your repository and the branch containing your completed 
assignment. Unless you created your own branches, the branch is called 
'main'**. You can access Gradescope through the Canvas assignment page.


## Overview : Lambda Calculus

The objective of this assignment is for you to understand
the **lambda-calculus**, and the notion of computation-by-substitution
i.e. substituting equals for equals.

The assignment is in the files:

1. `tests/01_pair.lc`
2. `tests/02_minus.lc`
3. `tests/03_fact.lc`



## Assignment Testing and Evaluation

All the points will be awarded automatically, by
**evaluating your functions against a test suite**.

When you run

```shell
$ make
```

or

```shell


$ stack test
```

Your last lines should have

```
All N tests passed (...)
OVERALL SCORE = ... / ...
```

**or**

```
K out of N tests failed
OVERALL SCORE = ... / ...
```

**If your output does not have one of the above your code 
will not receive any points until this is fixed**

The other lines will give you a readout for each test.
You are encouraged to try to understand the testing code,
but you will not be graded on this.


**REMARK**: For problems 1, when using `=d>`, you don't need to unfold
every definition. It is often easier to keep some definitions folded until
their code is needed.

## Problem 1: `01_pair.lc`

**NOTE: DO NOT** use the `=*>` or `=~>` operators
anywhere in your solution for this problem, or you
will get 0 points for the assignment.

**NOTE: YOU MAY** replace `=d>` with `=b>` in the
last line.


### Part (a) (15 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `OR FALSE TRUE` to `TRUE`.


### Part (b) (15 points)

In this part, we practice with an alternative way
to encode tuples using `PAIR`s as a building block.

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce 
`SND (SND (PAIR apple (PAIR banana grape)))` 
to `grape`.

We've supplied the first few steps to get you
started.


### Part (c) (15 points)

In this part, we'll practice with the encoding of
triples (3-tuples).

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `TRD3 (TRIPLE apple banana grape)` 
to `grape`.

What trade-offs do you see between the two encodings?
(You don't have to write down an answer.)



## Problem 2: `02_minus.lc`

In lecture, we mentioned how it was not at all clear
at first that the Lambda Calculus was a universal
programming language and that any computable function
could be encoded. The Church numerals, addition, 
or multiplicaiton were discovered early on.

Kleene discovered how to define the predecessor function,
`DEC` (short for decrement) at the dentist in 1932.
Here, we'll walk you through the steps to define
predecessor, subtraction, and equality.

**NOTE:** You only need to write lambda-calculus
definitions for `SKIP1`, `DEC`, `SUB`, `ISZ` and `EQL`
on lines 40-44 in the starter code.

You may make your own local definitions, but you
may only edit the file between the comments
`-- do not modify text BEFORE this line`
and 
`-- do not modify text AFTER this line`

If you modify **any other** other part of this file
you will get 0 points for the problem.

### Part (a) (30 points)

We encode a number like ten with a lambda term that
takes two arguments `f` and `x` and applies `f` to
`x` ten times. To get the predecessor of ten, i.e.
nine, we need to transform ten into a term that takes
arguments `f` and `x` and applies `f` to `x` only
nine times. What we need is some way to "skip one"
or "throw away" one application of `f`.

The general way to do this is to use a data structure,
such as a pair, to hold some extra "memory". We will
use a pair containing a boolean (used as a flag)
and the argument of our function. Look at the test
cases below for `SKIP1` and notice how the behavior
depends on the flag.

Replace the definition of `SKIP1` with a suitable
lambda-term (i.e. replace `TODO` with a suitable
term) so that the following reductions are valid:

```haskell
eval skip1_false :
  SKIP1 INC (PAIR FALSE ZERO)
  =~> (\b -> b TRUE ZERO)       --  PAIR TRUE ZERO
  -- No skip happened yet, so skip application here.

eval skip1_true_zero :
  SKIP1 INC (PAIR TRUE ZERO)
  =~> (\b -> b TRUE ONE)        -- PAIR TRUE ONE
  -- Skip already happened, so apply INC to ZERO

eval skip1_true_one :
  SKIP1 INC (PAIR TRUE ONE)
  =~> (\b -> b TRUE TWO)        -- PAIR TRUE TWO
  -- Skip already happened, so apply INC to ONE
```

Your definition of `SKIP1` should **not** assume that
it will be applied to the `INC` function but should work in
general.

### Part (b) (15 points)

Now that we can "skip one" application of a function,
define `DEC` to subtract one from a number. We don't
have negatives, so we specify that `DEC ZERO` should
reduce to `ZERO`.

Replace the definition of `DEC` (decrement-by-one)
with a suitable lambda-term (i.e. replace `TODO`
with a suitable term) so that the following reductions
are valid:

```haskell
eval decr_zero :
  DEC ZERO
  =~> ZERO

eval decr_one :
  DEC ONE
  =~> ZERO

eval decr_two :
  DEC TWO
  =~> ONE
```

### Part (c) (20 points)

Now use `DEC` to define subtraction.
Replace the definition of `SUB` (subtract) with a
suitable lambda-term (i.e. replace `TODO`
with a suitable term) so that the following
reductions are valid:

```haskell
eval sub_two_zero :
  SUB TWO ZERO
  =~> TWO

eval sub_two_one :
  SUB TWO ONE
  =~> ONE

eval sub_two_two :
  SUB TWO TWO
  =~> ZERO

eval sub_two_three :
  SUB ONE TWO
  =~> ZERO
```

### Part (d) (10 points)

In order to define equality, we need to be able 
to tell when a Church numeral is zero.

Replace the definition of `ISZ` (is-equal-to-zero)
with a suitable lambda-term (i.e. replace `TODO`
with a suitable term) so that the following
reductions are valid:

```haskell
eval isz_zero :
  ISZ ZERO
  =~> TRUE

eval isz_one :
  ISZ ONE
  =~> FALSE
```

Hint: You don't need to use part (a) (b) or (c) here.

### Part (e) (20 points)

Use the previous parts of this problem to define
a lambda term that takes two arguments `n` and `m`
and returns `TRUE` if these encode the same Church
numeral and `FALSE` if they encode different numerals.

Replace the definition of `EQL` (is-equal)
with a suitable lambda-term (i.e. replace
`TODO` with a suitable term) so that
the following reductions are valid:

```haskell
eval eq_zero_zero :
  EQL ZERO ZERO
  =~> TRUE

eval eq_zero_one :
  EQL ZERO ONE
  =~> FALSE

eval eq_one_two :
  EQL ONE TWO
  =~> FALSE

eval eq_two_two :
  EQL TWO TWO
  =~> TRUE
```


## Problem 3: `03_fact.lc` (60 public points)

In the last problem, we'll work through the
process of how to define the factorial function 
from discrete mathmematics without using recursion.

In part (a) of problem 2, you saw how using a data
structure with a bit of extra memory (think of 
having local variables to help implement a function)
was key to defining the predecessor function.

Here, we want to define a function that takes a Church
numeral `n` and returns the encoding of `n!`. We don't
need recursion because the encoding of `n` gives us the
ability to apply some function `n` times, which is how
we defined addition and multiplication. But factorial
isn't quite as straightforward because we need to multiply

```
n * (n-1) * (n-2) * ... * 3 * 2 * 1
```

which implies we have to both count from `1` to `n` and
keep track of the product we want to output.

Here's a skeleton for you to fill in:

```
let FACT     = \n -> FactOut (n FactFunc FactBase)
```

For inspiration, think of how a loop works: we run
the same code `n` times, and update some variables
each time. Instead of updating variables, we will 
take a data structure as input, and output the 
next values.

**NOTE:** You only need to write lambda-calculus
definitions for `FactBase`, `FactFunc`, `FactOut`
on lines 47-49 in the starter code.

You may make your own local definitions, but you
may only edit the file between the comments
`-- do not modify text BEFORE this line`
and 
`-- do not modify text AFTER this line`

If you modify **any other** other part of this file
you will get 0 points for the problem.

### Part (a) 

Define a data structure in `FactBase`
that will hold the values we
need to keep track of in order to define factorial.

### Part (b) 

Define a function `FactFunc` that will update the
data structure each time it is applied.

### Part (c) 

Define a function `FactOut` that will output only the 
part of your data structure that contains the final
answer.

Replace the definition of 
`FactBase`, `FactFunc`, and `FactOut`
with a lambda-terms (i.e. replace each
`TODO` with a suitable term) so that
the following reductions are valid:

```haskell
eval fact_zero :
  FACT ZERO
  =~> ONE

eval fact_one :
  FACT ONE
  =~> ONE

eval fact_two :
  FACT TWO
  =~> TWO

eval fact_three :
  FACT THREE
  =~> SIX
```
