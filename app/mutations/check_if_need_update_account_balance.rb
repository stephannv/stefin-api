class CheckIfNeedUpdateAccountBalance < Mutations::Command
  required do
    model :record_changes, class: 'Hash'
  end

  def execute
    %w[amount_cents group_modifier].any? { |attribute| record_changes.key?(attribute) }
  end
end
