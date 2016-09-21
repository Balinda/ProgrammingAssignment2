## Week 3 of R Programming.
## Since matrix inversion can be a costly computation, there may be some benefit
## to caching the inverse of a matrix rather than compute it repeatedly.
## These functions will cache the inverse of a matrix and reuse that value if requested again.
## 

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function (y) {                       ## Sets the original matrix and clears the inverse matrix
        x <<- y
        i <<- NULL
    }
    get <-function() x                          ## Gets the original matrix
    setinverse <- function(solve) i<<- solve    ## Stores the inverse
    getinverse <- function() i                  ## Gets the inverse or NA if it doesn't exist yet
    list (set=set, get=get, setinverse=setinverse, getinverse=getinverse)  ## Create a list of functions
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), then the cacheSolve 
## should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {   ## Return a matrix that is the inverse of 'x'
    i <- x$getinverse()            ## Check if the inverse already exists
    if(!is.null(i)){               ## If it does, use that value
        message("getting cached data")
        return(i)
    }
    m <- x$get()                   ## If not, start with the original matrix
    i <- solve(m,...)              ## Find the inverse of the matrix
    x$setinverse(i)                ## Store the inverse for future use
    i
}
