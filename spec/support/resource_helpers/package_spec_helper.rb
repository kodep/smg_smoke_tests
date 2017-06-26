module PackageSpecHelper
  def package
    return @package if @package
    @package = create(:af_package)

    def @package.percent_remain
      1 - discount.to_f / 100;
    end

    def @package.standard_price
      (price / percent_remain).round(2)
    end

    def @package.recalc_price(_standard_price)
      self.price = (_standard_price * percent_remain).round(2)
    end
    @package
  end
end