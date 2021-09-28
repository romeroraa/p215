import Parameters.@with_kw
using Pipe
using Plots
using DataFrames

@with_kw struct bivariate_gaussian
    μx::Float64 = 0
    μy::Float64 = 0
    σx::Float64 = 1
    σy::Float64 = 1
    ρ::Float64
    @assert ((ρ >= 0) & (ρ < 1))
end

function bvg_conditional_sample(
    bvg::bivariate_gaussian;
    given_x::Union{Float64,Nothing}=nothing,
    given_y::Union{Float64,Nothing}=nothing,
)
    @assert xor(isnothing(given_x), isnothing(given_y))

    if !isnothing(given_x)
        μ = bvg.μy + (bvg.ρ * bvg.σy / bvg.σx * (given_x - bvg.μx))
        σ = (1 - bvg.ρ^2)bvg.σy^2

    elseif !isnothing(given_y)
        μ = bvg.μx + (bvg.ρ * bvg.σx / bvg.σy * (given_y - bvg.μy))
        σ = (1 - bvg.ρ^2)bvg.σx^2
    end

    return randn() * sqrt(σ) + μ
end

function gibbs_sampler(bvg::bivariate_gaussian; n_iter::Int64=1000)
    samples = Array{Float64,2}(undef, n_iter, 2)

    y = 0.0

    for i in 1:n_iter
        x = bvg_conditional_sample(bvg; given_y=y)
        y = bvg_conditional_sample(bvg; given_x=x)

        samples[i, 1] = x
        samples[i, 2] = y
    end
    return samples
end

# Plot highly correlated example
ρ = 0.99
df = @pipe(
    bivariate_gaussian(; ρ=ρ) |>
    gibbs_sampler(_; n_iter=1000) |>
    DataFrame(_, ["x", "y"]) |>
    last(_, 800) # We only get last 800 entries to initialize burn-in
)
scatter(
    df.x,
    df.y;
    xlabel="X",
    ylabel="Y",
    color="purple",
    label=false,
    size=(450, 300),
    title="ρ = $ρ",
)
savefig("fig1.png")

# Plot not highly correlated example correlated example
ρ = 0.2
df = @pipe(
    bivariate_gaussian(; ρ=ρ) |>
    gibbs_sampler(_; n_iter=1000) |>
    DataFrame(_, ["x", "y"]) |>
    last(_, 800) # We only get last 800 entries to initialize burn-in
)
scatter(
    df.x,
    df.y;
    xlabel="X",
    ylabel="Y",
    color="purple",
    label=false,
    size=(450, 300),
    title="ρ = $ρ",
)
savefig("fig2.png")
