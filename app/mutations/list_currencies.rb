class ListCurrencies < Mutations::Command
  def execute
    Money::Currency.all.sort_by(&:iso_code)
  end
end
