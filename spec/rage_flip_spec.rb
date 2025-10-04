require 'spec_helper'

RSpec.describe RageFlip do
  describe RageFlip::Flipper do
    describe '.flip' do
      it 'flips text upside down' do
        result = RageFlip::Flipper.flip('Hello')
        expect(result).to eq('oʅʅǝH')
      end
    end

    describe '.rage_flip' do
      it 'adds rage emoticons to flipped text' do
        result = RageFlip::Flipper.rage_flip('test')
        expect(result).to include('(ノಠ益ಠ)ノ彡┻')
        expect(result).to include('┻')
      end
    end
  end

  describe RageFlip::Sarcasm do
    describe '.process' do
      it 'alternates case of characters' do
        result = RageFlip::Sarcasm.process('hello')
        expect(result).to eq('HeLlO')
      end
    end
  end

  describe RageFlip::Strikethrough do
    describe '.process' do
      it 'adds strikethrough characters' do
        result = RageFlip::Strikethrough.process('test')
        expect(result).to include("\u0336")
      end
    end
  end

  describe RageFlip::Underline do
    describe '.single_underline' do
      it 'adds single underline characters' do
        result = RageFlip::Underline.single_underline('test')
        expect(result).to include("\u0332")
      end
    end

    describe '.double_underline' do
      it 'adds double underline characters' do
        result = RageFlip::Underline.double_underline('test')
        expect(result).to include("\u0333")
      end
    end
  end

  describe RageFlip::Chaos do
    describe '.process' do
      it 'adds combining characters for chaos effect' do
        result = RageFlip::Chaos.process('test', 5)
        expect(result.length).to be > 4 # Should be longer than original
      end
    end

    describe '.set_chaos_level' do
      it 'sets chaos level to specific number' do
        result = RageFlip::Chaos.set_chaos_level('15')
        expect(ENV['CHAOS_LEVEL']).to eq('15')
        expect(result).to eq('chaos level is now 15')
      end
    end
  end
end