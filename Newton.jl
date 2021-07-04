import ForwardDiff
import LinearAlgebra
import Plots

function xplot(X1, X2)
    p = Plots.plot(X1, X2, legend = false, markershape = :circle)
    Plots.display(p)
    Plots.png("lab3.1")
end

function fplot(f::Function, F, X1, X2)
    x = 0:0.01:10
    y = 0:0.01:10
    p = Plots.surface(x, y, f, colorbar = false, opacity = 0.5, camera = (60, 30))

    p = Plots.plot!(X1, X2, F, legend = false)

    Plots.display(p)
    Plots.png("lab3.2")
end

function newton(f::Function, x, ε)
    i = 1
    X1 = Float64[]
    X2 = Float64[]
    F = Float64[]

    ∇ = ForwardDiff.gradient(f, x)

    append!(X1, x[1])
    append!(X2, x[2])
    append!(F, f(x))

    while LinearAlgebra.norm(∇) >= ε
        ∇ = ForwardDiff.gradient(f, x)
        H = ForwardDiff.hessian(f, x)
        Hi = LinearAlgebra.inv(H)

        x -= Hi * ∇

        append!(X1, x[1])
        append!(X2, x[2])
        append!(F, f(x))

        println("Step $i:\n\t∇ = $∇\n\tH ^ (-1) = $Hi\n\tε = $(LinearAlgebra.norm(∇))\n\t\tx$i = $x\n\t\tf$i = $(f(x))\n")

        i += 1
    end

    xplot(X1, X2)
    fplot((x, y) -> (x - 3) ^ 4 + (x - 3 * y) ^ 2, F, X1, X2)
end

newton(x -> (x[1] - 3) ^ 4 + (x[1] - 3 * x[2]) ^ 2, [10, 10], 0.1)
