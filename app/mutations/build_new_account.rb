class BuildNewAccount < Mutations::Command
  def execute
    Account.new
  end
end
