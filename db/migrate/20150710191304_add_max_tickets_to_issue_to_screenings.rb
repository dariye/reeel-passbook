class AddMaxTicketsToIssueToScreenings < ActiveRecord::Migration
  def change
    add_column :screenings, :max_tickets_to_issue, :integer, default: 1
  end
end
