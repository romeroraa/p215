# Session 1 for P215

# KR1: Julia can be run using the terminal, the JUlia REPL appears

# KR2: Execute via the Julia REPL basic arithmetic expressions such as 2+3 or 3^4
2 + 3
3^4

# KR3: Tried several basic mathematical opeations such as exponentiation / trig / exp
sin(π / 2)
cos(π / 2)
log(2)

# KR4: Switched to the four REPL modes
# Help ?
# Shell ;
# Pkg ] 

# KR5: Assign a generated 30 x 30 random matrix via the command rand()
A = rand(30, 30)

# KR6: Other things
using Plots
x = LinRange(-2π, 2π, 1024)
y = cos.(x)
plot(x, y)

@doc rand(30, 30);
@time rand(30, 30);
