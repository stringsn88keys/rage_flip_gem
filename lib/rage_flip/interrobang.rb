module RageFlip
  # Every text transform runs its input through this first, so `?!` and `!?`
  # come out as the interrobang ‽ (U+203D).
  class Interrobang
    INTERROBANG = "‽" # ‽
    PAIR = /\?!|!\?/

    # Each `?!` or `!?` pair becomes one ‽, scanning left to right without
    # overlap: `?!?!` → `‽‽`, `?!?` → `‽?`, `!!?` → `!‽`. `??` and `!!` are
    # left alone.
    def self.process(text)
      text.gsub(PAIR, INTERROBANG)
    end
  end
end
