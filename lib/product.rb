require 'error'
module LogivanTest
  class Product
    attr_accessor :code, :name, :price
    
    def initialize(params = {})
      raise Error::PARAMS_MUST_BE_HASH unless params.is_a? Hash
      @code = params[:code]
      @name = params[:name]
      @price = params[:price]
    end
  end
end