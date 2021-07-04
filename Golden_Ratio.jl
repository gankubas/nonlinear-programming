using Plots

function uncertainty(A, B, E)
    midpoints = Float64[]
    poz = Int64[]

    for i in 1:size(A, 1)
        append!(midpoints, (A[i] + B[i]) / 2)
        append!(poz, i)
    end

    plot(poz, midpoints, yerror = E, label = "Average")
    plot!(poz, A, label = "Minimum")
    plot!(poz, B, label = "Maximum")

    png("lab2")
end

function golden(a, b, f::Function, ε)
    A = Float64[]
    B = Float64[]
    E = Float64[]

    append!(A, a)
    append!(B, b)
    append!(E, (b - a) / 2)

    i = 0
    α = (√5 - 1) / 2

    λ = a + (1 - α) * (b - a)
    μ = a + α * (b - a)

    fλ = f(λ)
    fμ = f(μ)

    println("\nStep 1:")
    println("\n\tLower limit: ", a, "\n\tUpper limit: ", b, "\n\tError: ", b - a)

    while (b - a) > ε
        println("\nStep ", i + 2, ":\n\t\tλ: ", λ, "\n\t\tf(λ): ", fλ, "\n\t\tμ: ", μ, "\n\t\tf(μ): ", fμ)

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

        append!(A, a)
        append!(B, b)
        append!(E, (b - a) / 2)

        println("\n\tLower limit: ", a, "\n\tUpper limit: ", b, "\n\tError: ", b - a)

        i += 1
    end

    uncertainty(A, B, E)

    print("Xmin = ", (a + b) / 2)
end

golden(-3, 4, x -> x ^ 2 - x * cos(x), 0.01)
