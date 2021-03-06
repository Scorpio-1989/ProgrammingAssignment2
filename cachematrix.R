#Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix rather than compute it repeatedly (there are also alternatives to matrix inversion that we will not discuss here). 

#cachematrix file contains two functions: (i) makeCacheMatrix and (ii) cacheSolve

#makeCacheMatrix function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) { #x=matrix() checks that the data is a matrix otherwise it will return an error. Note that the matrix should be a square that it equal number of rows and columns.
  m <- NULL                                 #assigns NULL to variable m
  set <- function(y) {                      #function set() converts data from x to y and variable m to NULL
    x <<- y                                 
    m <<- NULL
  }
  get <- function() x                       #function get() returns the data
  setinverse <- function() m <<- solve(x)   #function setinverse() assign inverse of data to variable m
  getinverse <- function() m                #function getinverse() return the inverse of data 
  list(set = set, get = get,                #generates a list where the values are of functions set(), get(), setinverse(), getinverse()
       setinverse = setinverse,
       getinverse = getinverse)
}

#cacheSolve function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {            #takes a variable that has value generated by function makeCacheMatrix() as an argument
  m <- x$getinverse()                       #assigns value of variable m defined in function makeCacheMatrix()
  if(!is.null(m)==TRUE) {                   #checks if value of m is NULL or not, and if not then fetches the value of value variable m from function makeCacheMatrix()
    message("getting cached data")
    return(m)
  }
  data <- x$get()                           #if the value of m in function makeCacheMatrix() is NULL which means that the inverse of data has not been previously calculated then it assigns the new data to variable data
  m <- solve(data)                          #assigns the inverse of variable data to variable m
  x$setinverse()                            #assigns the inverse of variable data to function setinverse() defined in makeCacheMatrix() so that it can be stored as cache
  m                                         #prints value of variable m to the console which is the inverse of data
}
