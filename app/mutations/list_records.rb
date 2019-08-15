class ListRecords < Mutations::Command
  def execute
    Record.all
  end
end
