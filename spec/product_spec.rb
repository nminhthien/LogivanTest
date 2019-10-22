require_relative '../lib/error'
RSpec.describe LogivanTest::Product do
  it 'Init product successfully with default value' do
    product = described_class.new
    expect(product.code).to be nil
    expect(product.name).to be nil
    expect(product.price).to be nil
  end

  it 'Init product successfully with value' do
    product = described_class.new({code: 1, name: 'Test Name', price: 20})
    expect(product.code).to be 1
    expect(product.name).to eq 'Test Name'
    expect(product.price).to be 20
  end

  it 'Init product unsuccessfully with exception' do
    expect { described_class.new([]) }.to raise_error(LogivanTest::Error::PARAMS_MUST_BE_HASH)
  end
end