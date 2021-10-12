"""
        rk4(f, t, y₀)
My implementation of Fourth order Runge-Kutta method (RK4)

Arguments:
        f (function): function to be evaluated
        t (Vector{Float64}): time of values to evaluate
        y₀ (Float64): inital value 

"""
function rk4(f, t, y₀)
    n = length(t)
    y = zeros(n)
    y[1] = y₀
    for i in 1:n-1
        h = t[i+1] - t[i]
        k₁ = f(y[i], t[i])
        k₂ = f(y[i] + k₁*h/2, t[i] + h/2)
        k₃ = f(y[i] + k₂*h/2, t[i] + h/2)
        k₄ = f(y[i] + k₃*h, t[i] + h)
        y[i+1] = y[i] + (h/6)*(k₁ + 2k₂ + 2k₃ + k₄)
    end
    return y
end

