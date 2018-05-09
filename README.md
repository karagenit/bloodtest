# bloodtest

Let's say we have a population of N = 10,000, and we want to find each individual with a certain trait T. This trait has a likelihood of occurrence of P = 0.01, so E(T) = 100 in our population. Assuming we can group individuals together and test them as a pool, what is the most efficient grouping structure to reduce the # of tests required?

## Output

**CSV Naming**

`TRIALS-POPULATION-PROBABILITY-DIVISOR-GROUPRANGE.csv`

## Mathematics

Possible solution: calculate the 'expected contribution' (i.e. how many people we expect to determine as having/not having it) for each group size - the group size with the highest expected contribution should be the best.

```
C(x) = x * (q ^ x)
```

A group of `x` people has a `q^x` probability of having *none* with the trait (where `q = 1 - p` and `p` is the likelihood of occurrence).

The derivative `C'(x)` shows an intercept at (99.499, 0), indicating `C(x)` peaks at X = 99.499. Very odd that this doesn't seem to be proportional to population size.
