require_relative '../../lib/error'
RSpec.describe LogivanTest::DiscountPriceOnSpecificProductPromotionalRule do
  context 'Success on initialization' do
    it 'Create rule successfully' do
      discount_price_params = {
        product_code: 1,
        number_product_from: 2,
        discount_price: 8.5
      }
      rule = described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      expect(rule.priority).to eq 1
    end
  end
  context 'Error on initialization' do
    it 'Invalid product code' do
      discount_price_params = {
        product_code: nil,
        number_product_from: 2,
        discount_price: 8.5
      }
      expect { 
        described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price]) 
      }.to raise_error(LogivanTest::Error::PRODUCT_CODE_MUST_PRESENT)
    end

    it 'Invalid number product from with value is nil' do
      discount_price_params = {
        product_code: 1,
        number_product_from: nil,
        discount_price: 8.5
      }
      expect {
        described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      }.to raise_error(LogivanTest::Error::NUMBER_PRODUCT_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid number product from with value is negative number' do
      discount_price_params = {
        product_code: 1,
        number_product_from: -1,
        discount_price: 8.5
      }
      expect {
        described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      }.to raise_error(LogivanTest::Error::NUMBER_PRODUCT_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid number product from with value is not a number' do
      discount_price_params = {
        product_code: 1,
        number_product_from: 'aaa',
        discount_price: 8.5
      }
      expect {
        described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      }.to raise_error(LogivanTest::Error::NUMBER_PRODUCT_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid discount price with value is nil' do
      discount_price_params = {
        product_code: 1,
        number_product_from: 2,
        discount_price: nil
      }
      expect {
        described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      }.to raise_error(LogivanTest::Error::DISCOUNT_PRICE_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid discount price with value is negative number' do
      discount_price_params = {
        product_code: 1,
        number_product_from: 2,
        discount_price: -1
      }
      expect {
        described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      }.to raise_error(LogivanTest::Error::DISCOUNT_PRICE_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid discount price with value is not a number' do
      discount_price_params = {
        product_code: 1,
        number_product_from: 2,
        discount_price: 'aaa'
      }
      expect {
        described_class.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      }.to raise_error(LogivanTest::Error::DISCOUNT_PRICE_MUST_BE_POSITIVE_NUMBER)
    end
  end
end