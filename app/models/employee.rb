class Employee < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name, :position, :office, :age, :start_date], using: { tsearch: { prefix: true } }

  after_create_commit { broadcast_append_to "employees" }


  scope :active, -> { where(is_active: true) }
  scope :disable, -> { where(is_active: false) }
end
