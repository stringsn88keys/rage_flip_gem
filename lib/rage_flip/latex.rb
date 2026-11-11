module RageFlip
  # Replaces LaTeX-style markup with Unicode: `\int_0^1 x^2 dx` -> `∫₀¹ x² dx`.
  #
  # - `\name` commands from SYMBOLS (Greek letters, operators, relations,
  #   arrows, sets and logic). Unknown commands are left as typed.
  # - `^x`, `^{...}`, `_x`, `_{...}` become superscripts/subscripts when every
  #   character has one; otherwise they're left as typed.
  # - `\sqrt{x}` -> `√x`, `\sqrt{x+1}` -> `√(x+1)`, `\sqrt[3]{x}` -> `∛x`.
  # - `\frac{a}{b}` -> `a/b` (or a vulgar fraction like ½), with parentheses
  #   around multi-character parts.
  # - `\{`, `\}`, `\_`, `\^`, `\$`, `\%`, `\&`, `\#` and `\\` output the character.
  #
  # Spaces are kept as typed, and `$` delimiters pass through.
  class Latex
    SYMBOLS = {
      # Greek lowercase
      "alpha" => "α", "beta" => "β", "gamma" => "γ", "delta" => "δ", "epsilon" => "ε",
      "varepsilon" => "ε", "zeta" => "ζ", "eta" => "η", "theta" => "θ", "vartheta" => "ϑ",
      "iota" => "ι", "kappa" => "κ", "lambda" => "λ", "mu" => "μ", "nu" => "ν", "xi" => "ξ",
      "omicron" => "ο", "pi" => "π", "varpi" => "ϖ", "rho" => "ρ", "varrho" => "ϱ",
      "sigma" => "σ", "varsigma" => "ς", "tau" => "τ", "upsilon" => "υ", "phi" => "φ",
      "varphi" => "ϕ", "chi" => "χ", "psi" => "ψ", "omega" => "ω",
      # Greek uppercase
      "Gamma" => "Γ", "Delta" => "Δ", "Theta" => "Θ", "Lambda" => "Λ", "Xi" => "Ξ", "Pi" => "Π",
      "Sigma" => "Σ", "Upsilon" => "Υ", "Phi" => "Φ", "Psi" => "Ψ", "Omega" => "Ω",
      # Big operators and calculus
      "int" => "∫", "iint" => "∬", "iiint" => "∭", "oint" => "∮", "sum" => "∑", "prod" => "∏",
      "coprod" => "∐", "partial" => "∂", "nabla" => "∇", "infty" => "∞", "sqrt" => "√",
      # Binary operators
      "pm" => "±", "mp" => "∓", "times" => "×", "div" => "÷", "cdot" => "⋅", "ast" => "∗",
      "star" => "⋆", "circ" => "∘", "bullet" => "∙", "oplus" => "⊕", "otimes" => "⊗",
      # Relations
      "approx" => "≈", "neq" => "≠", "ne" => "≠", "leq" => "≤", "le" => "≤", "geq" => "≥",
      "ge" => "≥", "equiv" => "≡", "propto" => "∝", "sim" => "∼", "simeq" => "≃", "cong" => "≅",
      "ll" => "≪", "gg" => "≫", "perp" => "⊥", "parallel" => "∥", "mid" => "∣",
      # Arrows
      "to" => "→", "rightarrow" => "→", "leftarrow" => "←", "gets" => "←",
      "leftrightarrow" => "↔", "Rightarrow" => "⇒", "implies" => "⇒", "Leftarrow" => "⇐",
      "Leftrightarrow" => "⇔", "iff" => "⇔", "mapsto" => "↦", "uparrow" => "↑",
      "downarrow" => "↓",
      # Sets and logic
      "forall" => "∀", "exists" => "∃", "nexists" => "∄", "neg" => "¬", "lnot" => "¬",
      "land" => "∧", "wedge" => "∧", "lor" => "∨", "vee" => "∨", "in" => "∈", "notin" => "∉",
      "ni" => "∋", "subset" => "⊂", "supset" => "⊃", "subseteq" => "⊆", "supseteq" => "⊇",
      "cup" => "∪", "cap" => "∩", "emptyset" => "∅", "varnothing" => "∅", "setminus" => "∖",
      "therefore" => "∴", "because" => "∵",
      # Letterlike and miscellaneous
      "hbar" => "ℏ", "ell" => "ℓ", "Re" => "ℜ", "Im" => "ℑ", "aleph" => "ℵ", "wp" => "℘",
      "angle" => "∠", "degree" => "°", "prime" => "′", "cdots" => "⋯", "ldots" => "…",
      "dots" => "…", "vdots" => "⋮", "ddots" => "⋱",
      # Sizing commands with no plain-text equivalent
      "left" => "", "right" => ""
    }.freeze

    SUPERSCRIPTS = {
      "0" => "⁰", "1" => "¹", "2" => "²", "3" => "³", "4" => "⁴", "5" => "⁵", "6" => "⁶",
      "7" => "⁷", "8" => "⁸", "9" => "⁹", "+" => "⁺", "-" => "⁻", "=" => "⁼", "(" => "⁽",
      ")" => "⁾", " " => " ",
      "a" => "ᵃ", "b" => "ᵇ", "c" => "ᶜ", "d" => "ᵈ", "e" => "ᵉ", "f" => "ᶠ", "g" => "ᵍ",
      "h" => "ʰ", "i" => "ⁱ", "j" => "ʲ", "k" => "ᵏ", "l" => "ˡ", "m" => "ᵐ", "n" => "ⁿ",
      "o" => "ᵒ", "p" => "ᵖ", "r" => "ʳ", "s" => "ˢ", "t" => "ᵗ", "u" => "ᵘ", "v" => "ᵛ",
      "w" => "ʷ", "x" => "ˣ", "y" => "ʸ", "z" => "ᶻ",
      "A" => "ᴬ", "B" => "ᴮ", "D" => "ᴰ", "E" => "ᴱ", "G" => "ᴳ", "H" => "ᴴ", "I" => "ᴵ",
      "J" => "ᴶ", "K" => "ᴷ", "L" => "ᴸ", "M" => "ᴹ", "N" => "ᴺ", "O" => "ᴼ", "P" => "ᴾ",
      "R" => "ᴿ", "T" => "ᵀ", "U" => "ᵁ", "V" => "ⱽ", "W" => "ᵂ"
    }.freeze

    SUBSCRIPTS = {
      "0" => "₀", "1" => "₁", "2" => "₂", "3" => "₃", "4" => "₄", "5" => "₅", "6" => "₆",
      "7" => "₇", "8" => "₈", "9" => "₉", "+" => "₊", "-" => "₋", "=" => "₌", "(" => "₍",
      ")" => "₎", " " => " ",
      "a" => "ₐ", "e" => "ₑ", "h" => "ₕ", "i" => "ᵢ", "j" => "ⱼ", "k" => "ₖ", "l" => "ₗ",
      "m" => "ₘ", "n" => "ₙ", "o" => "ₒ", "p" => "ₚ", "r" => "ᵣ", "s" => "ₛ", "t" => "ₜ",
      "u" => "ᵤ", "v" => "ᵥ", "x" => "ₓ"
    }.freeze

    VULGAR_FRACTIONS = {
      "1/2" => "½", "1/3" => "⅓", "2/3" => "⅔", "1/4" => "¼", "3/4" => "¾", "1/5" => "⅕",
      "2/5" => "⅖", "3/5" => "⅗", "4/5" => "⅘", "1/6" => "⅙", "5/6" => "⅚", "1/7" => "⅐",
      "1/8" => "⅛", "3/8" => "⅜", "5/8" => "⅝", "7/8" => "⅞", "1/9" => "⅑", "1/10" => "⅒"
    }.freeze

    ROOTS = { "" => "√", "2" => "√", "3" => "∛", "4" => "∜" }.freeze

    ESCAPABLE = "{}_^$%&#\\".chars.freeze
    WHITESPACE = [" ", "\t", "\n", "\r"].freeze

    def self.process(text)
      convert(text.chars)
    end

    # `chars` is an array of single-codepoint strings.
    def self.convert(chars)
      out = +""
      i = 0
      while i < chars.length
        c = chars[i]
        if c == "\\"
          name = letters_at(chars, i + 1)
          if name.empty?
            if ESCAPABLE.include?(chars[i + 1])
              out << chars[i + 1]
              i += 2
            else
              out << c
              i += 1
            end
          elsif name == "sqrt" && (root = sqrt_at(chars, i + 1 + name.length))
            text, i = root
            out << text
          elsif name == "frac" && (frac = frac_at(chars, i + 1 + name.length))
            text, i = frac
            out << text
          else
            out << SYMBOLS.fetch(name) { "\\#{name}" }
            i += 1 + name.length
          end
        elsif c == "^" || c == "_"
          arg = argument_at(chars, i + 1)
          if arg
            inner, raw, i = arg
            converted = convert(inner)
            out << (script(converted, c == "^" ? SUPERSCRIPTS : SUBSCRIPTS) ||
                    "#{c}#{raw ? "{#{converted}}" : converted}")
          else
            out << c
            i += 1
          end
        else
          out << c
          i += 1
        end
      end
      out
    end
    private_class_method :convert

    def self.letters_at(chars, i)
      name = +""
      while i < chars.length && chars[i].match?(/\A[A-Za-z]\z/)
        name << chars[i]
        i += 1
      end
      name
    end
    private_class_method :letters_at

    # The argument starting at `i`: a {braced group}, a \command, or one
    # non-space character. Returns [inner_chars, braced?, next_index] or nil.
    def self.argument_at(chars, i)
      return nil if i >= chars.length
      c = chars[i]
      return nil if WHITESPACE.include?(c) || c == "}"

      if c == "{"
        close = matching_brace(chars, i)
        return nil unless close
        [chars[(i + 1)...close], true, close + 1]
      elsif c == "\\" && !(name = letters_at(chars, i + 1)).empty?
        [chars[i, 1 + name.length], false, i + 1 + name.length]
      elsif c == "\\" && ESCAPABLE.include?(chars[i + 1])
        [chars[i, 2], false, i + 2]
      else
        [[c], false, i + 1]
      end
    end
    private_class_method :argument_at

    def self.matching_brace(chars, open)
      depth = 0
      i = open
      while i < chars.length
        case chars[i]
        when "\\" then i += 1
        when "{" then depth += 1
        when "}"
          depth -= 1
          return i if depth.zero?
        end
        i += 1
      end
      nil
    end
    private_class_method :matching_brace

    def self.script(text, map)
      return nil if text.empty?
      mapped = text.chars.map { |ch| map[ch] }
      mapped.all? ? mapped.join : nil
    end
    private_class_method :script

    def self.wrap(text)
      text.length > 1 ? "(#{text})" : text
    end
    private_class_method :wrap

    # `\sqrt[n]{x}` starting just after "sqrt". Returns [text, next_index] or nil.
    def self.sqrt_at(chars, i)
      index = ""
      if chars[i] == "["
        offset = chars[i..].index("]")
        return nil unless offset
        close = i + offset
        index = convert(chars[(i + 1)...close]).strip
        i = close + 1
      end
      arg = argument_at(chars, i)
      return nil unless arg

      inner, _braced, after = arg
      sign = ROOTS[index] || "#{script(index, SUPERSCRIPTS) || index}√"
      ["#{sign}#{wrap(convert(inner))}", after]
    end
    private_class_method :sqrt_at

    # `\frac{a}{b}` starting just after "frac". Returns [text, next_index] or nil.
    def self.frac_at(chars, i)
      numerator = argument_at(chars, i)
      return nil unless numerator
      denominator = argument_at(chars, numerator[2])
      return nil unless denominator

      num = convert(numerator[0])
      den = convert(denominator[0])
      [VULGAR_FRACTIONS["#{num}/#{den}"] || "#{wrap(num)}/#{wrap(den)}", denominator[2]]
    end
    private_class_method :frac_at
  end
end
