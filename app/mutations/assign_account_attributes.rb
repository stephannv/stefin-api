class AssignAccountAttributes < Mutations::Command
  required do
    model :account, new_records: true
    hash :attributes do
      optional do
        string :name, max_length: 255
        string :color, matches: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/
        model :balance, class: 'Money'
        float :balance_cents
        string :balance_currency
      end
    end
  end

  def execute
    account.assign_attributes(attributes)
  end
end
