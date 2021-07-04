function F(n)
    fib = 1
    aux = fib

    for i in 2:n
        fib += aux
        aux = fib - aux
    end

    return fib
end

function fibonacci(a, b, f::Function, ε)
    i = 1
    Fn = F(1)

    lim = (b - a) / ε

    while Fn <= lim
        Fn = F(i)
        i += 1
    end

    n = i - 1 # poz max
    i = 1

    λ = a + (F(n - 2) / F(n)) * (b - a)
    μ = a + (F(n - 1) / F(n)) * (b - a)

    fλ = f(λ)
    fμ = f(μ)

    while (b - a) > ε
        println("\nStep $i:\n\t\tλ: $λ\n\t\tf(λ): $fλ\n\t\tμ: $μ\n\t\tf(μ): $fμ")

        if fλ < fμ
            b = μ
            μ = λ
            λ = a + (F(n - i - 2) / F(n - i)) * (b - a)

            fμ = fλ
            fλ = f(λ)
        else
            a = λ
            λ = μ
            μ = a + (F(n - i - 1) / F(n - i)) * (b - a)

            fλ = fμ
            fμ = f(μ)
        end

        println("\n\tLower limit: $a\n\tUpper limit: $b\n\tError: $(b - a)")

        i += 1
    end

    println("\nXmin = $((a + b) / 2)");
end

fibonacci(0, 2, x -> x ^ 4 - 14 * x ^ 3 + 60 * x ^ 2 - 70 * x, 0.3)
