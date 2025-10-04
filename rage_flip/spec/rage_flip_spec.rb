require 'spec_helper'

RSpec.describe RageFlip do
  describe '.flip' do
    it 'flips the arguments passed to it' do
      result = RageFlip.flip('hello', 'world')
      expect(result).to eq(['world', 'hello'])
    end

    it 'handles an empty argument list' do
      result = RageFlip.flip()
      expect(result).to eq([])
    end

    it 'flips multiple arguments' do
      result = RageFlip.flip('one', 'two', 'three')
      expect(result).to eq(['three', 'two', 'one'])
    end
  end

  describe '.copy_to_clipboard' do
    before do
      allow(RageFlip).to receive(:system)
    end

    it 'copies the result to the clipboard on macOS' do
      allow(RageFlip).to receive(:os).and_return(:mac)
      RageFlip.copy_to_clipboard('flipped text')
      expect(RageFlip).to have_received(:system).with("echo 'flipped text' | pbcopy")
    end

    it 'copies the result to the clipboard on Linux' do
      allow(RageFlip).to receive(:os).and_return(:linux)
      RageFlip.copy_to_clipboard('flipped text')
      expect(RageFlip).to have_received(:system).with("echo 'flipped text' | xclip -selection clipboard")
    end

    it 'copies the result to the clipboard on Windows' do
      allow(RageFlip).to receive(:os).and_return(:windows)
      RageFlip.copy_to_clipboard('flipped text')
      expect(RageFlip).to have_received(:system).with("echo 'flipped text' | clip")
    end
  end
end