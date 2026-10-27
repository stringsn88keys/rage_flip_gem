module RageFlip
  class Flipper
    FORWARD = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-=!@#$%^&*()_+ "
    BACKSIDEDOWN = " +‾()*⅋^%$#{@¡}=-068𝘓95ߤƐᘔ⇂zʎxʍʌnʇsɹbdouɯʅʞɾᴉɥƃⅎǝpɔqɐZ⅄XϺɅՈꓕSꓤÒԀONƜ⅂ꓘᒋIH⅁ᖵƎᗡϽꓭ∀"

    def self.flip(word)
      # Create the upside down map by reversing the backsidedown string
      upsidedown = BACKSIDEDOWN.reverse

      # Create mapping from forward to upsidedown characters
      upsidedownmap = {}
      FORWARD.each_char.with_index do |char, index|
        upsidedownmap[char] = upsidedown[index] if upsidedown[index]
      end

      # Flip the word: reverse the string and map each character
      flipped = ""
      word.each_char do |char|
        mapped_char = upsidedownmap[char] || char
        flipped = mapped_char + flipped
      end

      flipped
    end

    def self.rage_flip(text)
      rageflip_front = "(ノಠ益ಠ)ノ彡┻"
      rageflip_back = "┻"

      "#{rageflip_front}#{flip(text)}#{rageflip_back}"
    end

    def self.table_flip(text)
      table_flip_front = "(╯°□°)╯︵┻"
      table_flip_back = " ┻"

      "#{table_flip_front}#{flip(text)}#{table_flip_back}"
    end

    def self.flip_text(text)
      flip(text)
    end
  end
end
