module Extensions
  module MoneyExtension
    def formatted
      format(symbol: currency.to_s + ' ').strip
    end
  end
end
