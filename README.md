# Assignment 2 : Lambda Calculus (200 points)

## Working Environment

There are a few different ways that you can work on this assignment.

# GitHub Codespaces


# Devcontainer

We have created a [VS Code Development Container](https://code.visualstudio.com/docs/remote/containers) 
to help bootstrap your Haskell/Elsa development. This is a Docker container 
that is pre-configured with a Haskell environment that you can interact with 
directly from [VS Code](https://code.visualstudio.com/Download).

This requires a bit more setup work and requires having Docker installed and 
running. This method may not work out on Mac M1s -- contact us for support if
you run into trouble on a Mac M1. 

You can download the latest version of the [devcontainer here](). 
See the included [README]() for installation instructions.


## Submission Instructions
To submit your code, first commit and push your repository to GitHub. To see the output of the auto-grader tests, click 'Pull Requests' and select Feedback. You can see the output of the tests under the Checks tab.

**When you have completed the assignment, submit your repo to gradescope by selecting your repository and the branch containing your completed assignment. Unless you created your own branches, the branch is called 'main'**. You can access Gradescope through the Canvas assignment page.

## Overview : Lambda Calculus

The objective of this assignment is for you to understand
the **lambda-calculus**, and the notion of computation-by-substitution
i.e. substituting equals for equals.

The assignment is in the files:

1. `tests/01_pair.lc`
2. `tests/02_minus.lc`
3. `tests/03_fact.lc`

You can use GitHub Codespaces to work on this assignment by running VS Code from within your web browser

You can also edit these files and then run them locally on your machine:,

* by running `$ stack exec elsa path/to/file.lc` on a unix machine (with stack installed), OR
* by locally installing `elsa` following [these instructions](https://github.com/ucsd-progsys/elsa#install)

Finally, a fallback option is to run the assignment files 
through the [web interface](https://goto.ucsd.edu/elsa/index.html).

If you run it online, be sure to **copy back the result** to the corresponding local file before submitting.

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

## Problem 1: `01_bool.lc`

**NOTE: DO NOT** use the `=*>` or `=~>` operators
anywhere in your solution for this problem, or you
will get 0 points for the assignment.

**NOTE: YOU MAY** replace `=d>` with `=b>` in the
last line.


### Part (a) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `NOT TRUE` to `FALSE`.


### Part (b) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `AND TRUE FALSE` to `FALSE`.


### Part (c) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `OR FALSE TRUE` to `TRUE`.


## Problem 1: `02_plus.lc`

**NOTE: DO NOT** use the `=*>` or `=~>` operators
anywhere in your solution for this problem, or you
will get 0 points for the assignment.

**NOTE: YOU MAY** replace `=d>` with `=b>` in the
last line.


### Part (a) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `INC ONE` to `TWO`.

### Part (b) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `ADD ZERO ZERO` to `ZERO`.

### Part (c) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `ADD TWO TWO` to `FOUR`.

## Problem 2: `02_minus.lc`

**NOTE:** You only need to write lambda-calculus
definitions for `SKIP1`, `DEC`, `SUB`, `ISZ` and `EQL`.
If you modify **any other** other part of the file
you will get 0 points for the assignment.

### Part (a) (30 points)

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

### Part (b) (15 points)

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

### Part (e) (20 points)

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
