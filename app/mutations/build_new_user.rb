class BuildNewUser < Mutations::Command
  def execute
    User.new
  end
end
