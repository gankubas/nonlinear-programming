import ForwardDiff
import LinearAlgebra

function golden(a, b, f::Function, ε)
    i = 0
    α = (√5 - 1) / 2

    λ = a + (1 - α) * (b - a)
    μ = a + α * (b - a)

    fλ = f(λ)
    fμ = f(μ)

    while (b - a) > ε
        if fλ < fμ
            b = μ
            μ = λ
            λ = a + (1 - α) * (b - a)

            fμ = fλ
            fλ = f(λ)
        else
            a = λ
            λ = μ
            μ = a + α * (b - a)

            fλ = fμ
            fμ = f(μ)
        end

        i += 1
    end

    return (a + b) / 2
end

function descent(f::Function, x, ε)
    i = 1

    ∇ = ForwardDiff.gradient(f, x)

    while LinearAlgebra.norm(∇) >= ε
        ∇ = ForwardDiff.gradient(f, x)

        λ = golden(-20, 20, y -> f(x - y * ∇), 0.000001)

        x -= λ * ∇

        println("Step $i:\n\tλ = $λ\n\t\tx: $x\n\t\t∇: $∇")

        i += 1;
    end
end

descent(x -> -1 * x[2] + x[1] ^ 2 - 2 * x[1] * x[2] + 2 * x[2] ^ 2, [1, 1], 0.1)
