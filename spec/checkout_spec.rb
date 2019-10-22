require 'yaml'
require_relative '../lib/checkout'
require_relative '../lib/product'
require_relative '../lib/error'
require_relative '../lib/promotional_rules/discount_percent_on_total_price_promotional_rule'
require_relative '../lib/promotional_rules/discount_price_on_specific_product_promotional_rule'

RSpec.describe LogivanTest::Checkout do
  let(:fixtures) { YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures.yml')) }
  
  def create_checkout
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
    LogivanTest::Checkout.new(promotional_rules)
  end
  
  context 'Checkout without promotion' do
    let(:ft_products_no_promotion) { fixtures['purchased_products_not_applied_promotion'] }
    let(:products_no_promotion) { ft_products_no_promotion.map do |product|
        # symbolize keys
        product = product.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}
        LogivanTest::Product.new(product)
      end
    }
    
    it 'Does not have any promotion rule' do 
      checkout = LogivanTest::Checkout.new
      products_no_promotion.each do |product|
        checkout.scan product
      end
      original_total_price = products_no_promotion.inject(0) { |sum, product| sum + product.price }
      expect(checkout.total).to equal(original_total_price)
      expect(checkout.total).to equal(59.2)
    end

    it 'Have promotional rules but does not match condition to apply' do
      checkout = create_checkout
      products_no_promotion.each do |product|
        checkout.scan product
      end
      original_total_price = products_no_promotion.inject(0) { |sum, product| sum + product.price }
      expect(checkout.total).to equal(original_total_price)
      expect(checkout.total).to equal(59.2)
    end
  end
  
  context 'Only one promotional rule is applied' do
    let(:ft_products_percent_promotion) { fixtures['purchased_products_applied_total_price_promotions'] }
    let(:ft_products_price_promotion) { fixtures['purchased_products_applied_specific_product_promotions'] }
    let(:products_percent_promotion) { ft_products_percent_promotion.map do |product|
        # symbolize keys
        product = product.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}
        LogivanTest::Product.new(product)
      end
    }
    let(:products_price_promotion) { ft_products_price_promotion.map do |product|
      # symbolize keys
      product = product.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}
      LogivanTest::Product.new(product)
    end
    }
    let(:ft_products_many_price_promotion) { fixtures['purchased_products_applied_many_specific_product_promotions'] }
    let(:products_many_price_promotion) { ft_products_many_price_promotion.map do |product|
      # symbolize keys
      product = product.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}
      LogivanTest::Product.new(product)
    end
    }
    
    it 'Discount percent on total price' do
      checkout = create_checkout
      products_percent_promotion.each do |product|
        checkout.scan product
      end
      original_total_price = products_percent_promotion.inject(0) { |sum, product| sum + product.price }
      expect(checkout.total).to equal(original_total_price * 0.9)
      expect(checkout.total).to equal(66.78)
    end
    
    it 'Discount price on a specific product' do
      checkout = create_checkout
      products_price_promotion.each do |product|
        checkout.scan product
      end
      original_total_price = products_price_promotion.inject(0) { |sum, product| sum + product.price }
      expect(checkout.total).to equal(original_total_price - (0.75 * 2))
      expect(checkout.total).to equal(36.95)
    end

    it 'Discount price on many specific products' do
      discount_price_params_1 = {
        product_code: 001,
        number_product_from: 2,
        discount_price: 8.5
      }
      discount_price_params_3 = {
        product_code: 003,
        number_product_from: 1,
        discount_price: 18.5
      }
      promotional_rules = [
        LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params_1[:product_code], discount_price_params_1[:number_product_from], discount_price_params_1[:discount_price]),
        LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params_3[:product_code], discount_price_params_3[:number_product_from], discount_price_params_3[:discount_price])
      ]
      checkout = LogivanTest::Checkout.new(promotional_rules)
      products_many_price_promotion.each do |product|
        checkout.scan product
      end
      original_total_price = products_many_price_promotion.inject(0) { |sum, product| sum + product.price }
      expect(checkout.total).to equal((original_total_price - (0.75 * 2) - (1.45 * 2)).round(2))
      expect(checkout.total).to equal(54.0)
    end
  end 
  
  context 'Multiple promotional rules are applied' do
    let(:ft_products_multiple_promotion) { fixtures['purchased_products_applied_multiple_promotions'] }
    let(:products_multiple_promotion) { ft_products_multiple_promotion.map do |product|
      # symbolize keys
      product = product.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}
      LogivanTest::Product.new(product)
    end
    }
    it 'Discount price on a specific product and percent on total price' do
      checkout = create_checkout
      products_multiple_promotion.each do |product|
        checkout.scan product
      end
      original_total_price = products_multiple_promotion.inject(0) { |sum, product| sum + product.price }
      expect(checkout.total).to equal(((original_total_price - (0.75 * 2)) * 0.9).round(2))
      expect(checkout.total).to equal(73.76)
    end
  end
  
  context 'Checkout with exception' do
    let(:ft_products_price_promotion) { fixtures['purchased_products_applied_specific_product_promotions'] }
    let(:products_price_promotion) { ft_products_price_promotion.map do |product|
        # symbolize keys
        product = product.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}
        LogivanTest::Product.new(product)
      end
    }
    it 'The discount price is greater than normal price' do
      discount_price_params = {
        product_code: 001,
        number_product_from: 2,
        discount_price: 10
      }
      promotional_rules = [
        LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      ]
      checkout = LogivanTest::Checkout.new(promotional_rules)
      products_price_promotion.each do |product|
        checkout.scan product
      end
      expect {
        checkout.total
      }.to raise_error(LogivanTest::Error::DISCOUNT_PRICE_MUST_BE_SMALLER_NORMAL_PRICE)
    end

    it 'Checkout scan with invalid product' do
      discount_price_params = {
        product_code: 001,
        number_product_from: 2,
        discount_price: 10
      }
      promotional_rules = [
        LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      ]
      checkout = LogivanTest::Checkout.new(promotional_rules)
      expect {
        checkout.scan({code: 1})
      }.to raise_error(RuntimeError)
    end

    it 'Checkout scan with no product' do
      discount_price_params = {
        product_code: 001,
        number_product_from: 2,
        discount_price: 10
      }
      promotional_rules = [
        LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params[:product_code], discount_price_params[:number_product_from], discount_price_params[:discount_price])
      ]
      checkout = LogivanTest::Checkout.new(promotional_rules)
      expect {
        checkout.scan
      }.to raise_error(ArgumentError)
    end

    it 'Checkout with invalid rules' do
      promotional_rules = [
        {test: "test"}
      ]
      expect {
        LogivanTest::Checkout.new(promotional_rules)
      }.to raise_error(LogivanTest::Error::INVALID_PROMOTION_RULE)
    end

    it 'Checkout with multiple rules for a product' do
      discount_price_params_1 = {
        product_code: 001,
        number_product_from: 2,
        discount_price: 10
      }
      discount_price_params_2 = {
        product_code: 001,
        number_product_from: 3,
        discount_price: 15
      }
      promotional_rules = [
        LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params_1[:product_code], discount_price_params_1[:number_product_from], discount_price_params_1[:discount_price]),
        LogivanTest::DiscountPriceOnSpecificProductPromotionalRule.new(discount_price_params_2[:product_code], discount_price_params_2[:number_product_from], discount_price_params_2[:discount_price])
      ]
      expect {
        LogivanTest::Checkout.new(promotional_rules)
      }.to raise_error(LogivanTest::Error::CANNOT_APPLY_MULTI_RULES_FOR_A_PRODUCT_CODE)
    end
    
    it 'Checkout with multiple rules for discount percent base on total price' do
      discount_percent_params_1 = {
        total_price_from: 60,
        discount_percent: 10
      }
      discount_percent_params_2 = {
        total_price_from: 70,
        discount_percent: 15
      }
      promotional_rules = [
        LogivanTest::DiscountPercentOnTotalPricePromotionalRule.new(discount_percent_params_1[:total_price_from], discount_percent_params_1[:discount_percent]),
        LogivanTest::DiscountPercentOnTotalPricePromotionalRule.new(discount_percent_params_2[:total_price_from], discount_percent_params_2[:discount_percent])
      ]
      expect {
        LogivanTest::Checkout.new(promotional_rules)
      }.to raise_error(LogivanTest::Error::CANNOT_APPLY_MULTI_RULES_FOR_TOTAL_PRICE)
    end
  end
end