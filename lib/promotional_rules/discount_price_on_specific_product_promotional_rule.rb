require_relative 'promotional_rule'
require_relative '../../lib/error'
module LogivanTest
  class DiscountPriceOnSpecificProductPromotionalRule < PromotionalRule
    attr_reader :priority, :product_code
    
    def initialize(product_code, number_product_from, discount_price, priority = 1)
      raise Error::PRODUCT_CODE_MUST_PRESENT unless product_code
      raise Error::NUMBER_PRODUCT_MUST_BE_POSITIVE_NUMBER if !number_product_from || !number_product_from.is_a?(Integer) || !number_product_from.positive?
      raise Error::DISCOUNT_PRICE_MUST_BE_POSITIVE_NUMBER if !discount_price || (!discount_price.is_a?(Float) && !discount_price.is_a?(Integer)) || !discount_price.positive?
      @product_code = product_code
      @number_product_from = number_product_from
      @discount_price = discount_price
      @priority = priority
    end
    
    def calculate_discount
      product_price = applied_products.first.price
      raise Error::DISCOUNT_PRICE_MUST_BE_SMALLER_NORMAL_PRICE if @discount_price > product_price
      return applied_products.length * (product_price - @discount_price) if discountable?
      0
    end
    
    private
    def applied_products
      @products.select { |product| product.code == @product_code }
    end

    def discountable?
      applied_products.length >= @number_product_from
    end
  end
end