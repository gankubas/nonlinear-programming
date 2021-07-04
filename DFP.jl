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

function DFP(f::Function, x, D, ε)
    i = 1

    ∇ = ForwardDiff.gradient(f, x)

    while LinearAlgebra.norm(∇) >= ε
        d = -1 * D * ∇

        λ = golden(-20, 20, y -> f(x + y * d), 0.000001)

        p = λ * d
        x += p

        pre∇ = ∇
        ∇ = ForwardDiff.gradient(f, x)

        q = ∇ - pre∇
        D += (p * transpose(p)) / (transpose(p) * q) - (D * q * transpose(q) * D) / (transpose(q) * D * q)

        print("Step $i:\n\tλ = $λ\n\t\tx: $x\n\t\t∇: $∇\n\t\t\tp: $p\n\t\t\tq: $q\nD: ")
        display(D)
        println()

        i += 1
    end
end

DFP(x -> 0.5 * transpose(x) * [4 2; 2 2] * x - transpose(x) * [-1; 1], [0; 0], [1 0; 0 1], 0.1)
