function dichotomy(a, b, f::Function, ε, δ)
    i = 0

    while (b - a) > ε
        λ = (a + b) / 2 - δ
        μ = (a + b) / 2 + δ

        println("\nStep $(i + 1):\n\t\tλ: $λ\n\t\tf(λ): $(f(λ))\n\t\tμ: $μ\n\t\tf(μ): $(f(μ))")

        if f(λ) < f(μ)
            b = μ
            println("\t\tf(λ) < f(μ) => [a$(i + 1); b$(i + 1)] = [a$i; μ$i]")
        else
            a = λ
            println("\n\t\tf(λ) > f(μ) => [a$(i + 1); b$(i + 1)] = [λ$i; b$i]")
        end

        println("\n\tLower limit: $a\n\tUpper limit: $b\n\tError: $(b - a)")

        i += 1
    end

    println("\nXmin = $((a + b) / 2)");
end

dichotomy(0, 1, x -> x * (x - 1.5), 0.1, 0.001)
