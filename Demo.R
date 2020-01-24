
# Demo --------------------------------------------------------------------
# The idea of this script is to show how to use the functions in this package.


## Dummy Data
dummy_data <- data.frame(y = rnorm(100),
                         X1= sample(letters[1:4], size = 100, replace = T),
                         X2= sample(LETTERS[1:3], size = 100, replace = T),
                         X3= sample(c("1","2","3"), size = 100, replace = T)
                         )

## Mean response by 1 class
mean_by_class(dataset = dummy_data,
              factors = "X1",
              response = "y"
)

## Mean response by 2 classes
mean_by_class(dataset = dummy_data,
              factors = c("X1","X2"),
              response = "y"
)

## Histogram for 1 variable
graph_histogram(dataset = dummy_data,
                factors = c("X1"))


## Histogram for 2 variables
graph_histogram(dataset = dummy_data,
                factors = c("X2","X1"))
