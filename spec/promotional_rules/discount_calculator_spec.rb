RSpec.describe LogivanTest::DiscountCalculator do
  it 'Init discount calculator successfully with default value' do
    calculator = described_class.new()
    expect(calculator.rules).to eq []
    expect(calculator.products).to eq []
    expect(calculator.original_total_price).to eq 0
  end

  it 'Init discount calculator successfully' do
    discount_percent_params = {
      total_price_from: 60,
      discount_percent: 10
    }
    discount_price_params = {
      product_code: 001,
      number_product_from: 2,
      discount_price: 8.5
    }
    promotional_rules = [
      LogivanTest::DiscountPercentOnTotalPricePromotionalRule.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent]),
      LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
    ]
    expected_promotional_rules = [
      LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price]),
      LogivanTest::DiscountPercentOnTotalPricePromotionalRule.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
    ]
    calculator = described_class.new(promotional_rules)
    # Expected promotional rules that already been ordered by priority
    expect(calculator.rules.first.class.name).to eq 'LogivanTest::DiscountPriceOnSpecificProductPromotionalRule'
    expect(calculator.products).to eq []
    expect(calculator.original_total_price).to eq 0
  end
end