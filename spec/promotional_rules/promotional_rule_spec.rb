RSpec.describe LogivanTest::PromotionalRule do
  it 'Create promotional rule successfully' do
    rule = described_class.new
    expect(rule.products).to eq []
    expect(rule.current_total).to eq 0
  end
end