class BuildNewCategory < Mutations::Command
  def execute
    Category.new
  end
end
