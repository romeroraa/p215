"""
    mandel(c)
Given a complex number, computes whether after a certain number of iterations
`f_c(z) = z^2 + c` converges or not.
"""
function mandel(c)
    z = c
    maxiter = 80
    for n in 1:maxiter
        if abs(z) > 2
            return n - 1
        end
        z = z^2 + c
    end
    return maxiter
end

"""
    mandel_grid( xrange::Tuple{Float64,Float64}, yrange::Tuple{Float64,Float64}; n=100 )
Applies the `mandel()` function over a grid with set xrange, yrange with shape `n` x `n`.

Arguments:
    xrange (Tuple{FLoat64, Float64}): bounds of the grid along x. Defaults to (-1.0, 1.0)
    yrange (Tuple{FLoat64, Float64}): bounds of the grid along y. Defaults to (-1.0, 1.0)
    n (Int64): Dimensions of the grid (length of one side). Defaults to 100.

"""
function mandel_grid(;
    xrange::Tuple{Float64,Float64}=(-1.0, 1.0),
    yrange::Tuple{Float64,Float64}=(-1.0, 1.0),
    n::Int64=100,
)
    grid = zeros(n, n)
    xval = range(xrange[1], xrange[2]; length=n)
    yval = range(yrange[1], yrange[2]; length=n)
    for i in 1:n, j in 1:n
        grid[i, j] = mandel(xval[i] + im * yval[j])
    end
    return grid
end
