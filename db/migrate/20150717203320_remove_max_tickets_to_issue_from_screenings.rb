class RemoveMaxTicketsToIssueFromScreenings < ActiveRecord::Migration
  def change
    remove_column :screenings, :max_tickets_to_issue, :integer
  end
end
