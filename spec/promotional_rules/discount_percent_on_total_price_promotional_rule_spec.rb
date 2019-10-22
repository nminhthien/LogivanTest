require_relative '../../lib/error'
RSpec.describe LogivanTest::DiscountPercentOnTotalPricePromotionalRule do
  context 'Success on initialization' do
    it 'Create rule successfully' do
      discount_percent_params = {
        total_price_from: 60,
        discount_percent: 10
      }
      rule = described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      expect(rule.priority).to eq 2
    end
  end

  context 'Error on initialization' do
    it 'Invalid total price from with value is nil' do
      discount_percent_params = {
        total_price_from: nil,
        discount_percent: 10
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::TOTAL_PRICE_FROM_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid total price from with value is negative number' do
      discount_percent_params = {
        total_price_from: -1,
        discount_percent: 10
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::TOTAL_PRICE_FROM_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid total price from with value is not a number' do
      discount_percent_params = {
        total_price_from: 'aaas',
        discount_percent: 10
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::TOTAL_PRICE_FROM_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid total price from with value is zero' do
      discount_percent_params = {
        total_price_from: 0,
        discount_percent: 10
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::TOTAL_PRICE_FROM_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid discount percent with value is nil' do
      discount_percent_params = {
        total_price_from: 60,
        discount_percent: nil
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::DISCOUNT_PERCENT_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid discount percent with value is negative number' do
      discount_percent_params = {
        total_price_from: 60,
        discount_percent: -1
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::DISCOUNT_PERCENT_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid discount percent with value is not a number' do
      discount_percent_params = {
        total_price_from: 60,
        discount_percent: 'aaa'
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::DISCOUNT_PERCENT_MUST_BE_POSITIVE_NUMBER)
    end

    it 'Invalid discount percent with value is zero' do
      discount_percent_params = {
        total_price_from: 60,
        discount_percent: 0
      }
      expect {
        described_class.new(discount_percent_params[:total_price_from], discount_percent_params[:discount_percent])
      }.to raise_error(LogivanTest::Error::DISCOUNT_PERCENT_MUST_BE_POSITIVE_NUMBER)
    end
  end
end