require './lib/visitor'

RSpec.describe Visitor do
  it 'exists' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    expect(visitor1.name).to eq('Bruce')
    expect(visitor1.height).to eq(54)
    expect(visitor1.spending_money).to eq(10)
    expect(visitor1.preferences).to eq([])
  end

  it '#add_preference' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    visitor1.add_preference(:gentle)
    visitor1.add_preference(:water)

    expect(visitor1.preferences).to eq(%i[gentle water])
  end

  it '#tall_enough?' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')

    expect(visitor1.tall_enough?(54)).to eq(true)
    expect(visitor2.tall_enough?(54)).to eq(false)
    expect(visitor3.tall_enough?(54)).to eq(true)
    expect(visitor1.tall_enough?(64)).to eq(false)
  end

  it '#pay' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor1.pay(1)
    visitor1.pay(1)
    expect(visitor1.spending_money).to eq(8)
  end
end
