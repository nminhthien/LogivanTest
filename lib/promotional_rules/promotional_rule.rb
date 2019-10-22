module LogivanTest
  class PromotionalRule
    attr_accessor :products, :current_total
    
    def initialize
      @products = []
      @current_total = 0
    end
  end
end