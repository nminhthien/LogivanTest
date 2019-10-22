require_relative '../lib/promotional_rules/discount_calculator'
require 'error'
module LogivanTest
  class Checkout
    def initialize(promotional_rules = [])
      applied_products = []
      has_discount_total_price = false 
      promotional_rules.each do |rule|
        raise Error::INVALID_PROMOTION_RULE unless rule.is_a? PromotionalRule
        case rule.class.name
        when 'LogivanTest::DiscountPriceOnSpecificProductPromotionalRule'
          raise Error::CANNOT_APPLY_MULTI_RULES_FOR_A_PRODUCT_CODE if applied_products.include?(rule.product_code)
          applied_products << rule.product_code
        when 'LogivanTest::DiscountPercentOnTotalPricePromotionalRule'
          raise Error::CANNOT_APPLY_MULTI_RULES_FOR_TOTAL_PRICE if has_discount_total_price
          has_discount_total_price = true
        end
      end
      
      @rules = promotional_rules
      @products = []
    end
    
    def scan(product)
      raise Error::INVALID_PRODUCT unless product.is_a? Product
      @products << product
    end
    
    def total
      original_total_price = @products.inject(0) { |sum, product| sum + product.price }
      discount_calculator = DiscountCalculator.new(@rules, @products, original_total_price)
      total_discount = discount_calculator.calculate_total_discount
      (original_total_price - total_discount).round(2)
    end
  end
end