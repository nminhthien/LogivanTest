require_relative 'promotional_rule'
require_relative '../../lib/error'
module LogivanTest
  class DiscountPercentOnTotalPricePromotionalRule < PromotionalRule
    attr_reader :priority
    
    def initialize(total_price_from, discount_percent, priority = 2)
      raise Error::TOTAL_PRICE_FROM_MUST_BE_POSITIVE_NUMBER if !total_price_from || (!total_price_from.is_a?(Float) && !total_price_from.is_a?(Integer)) || !total_price_from.positive?
      raise Error::DISCOUNT_PERCENT_MUST_BE_POSITIVE_NUMBER if !discount_percent || !discount_percent.is_a?(Integer) || !discount_percent.positive?
      @total_price_from = total_price_from
      @discount_percent = discount_percent
      @priority = priority
    end
    
    def calculate_discount
      return @current_total * @discount_percent / 100 if discountable?
      0
    end
    
    private
    def discountable?
      @current_total >= @total_price_from
    end
  end
end