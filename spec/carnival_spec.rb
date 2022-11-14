require './lib/carnival'

RSpec.describe Carnival do
    it 'exists' do
        carnival = Carnival.new(3)
        expect(carnival.duration).to eq(3)
    end
end