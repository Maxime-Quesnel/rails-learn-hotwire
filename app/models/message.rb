class Message < ApplicationRecord
  validates_uniqueness_of :content

  after_create_commit { broadcast_append_to "messages" }

  after_destroy_commit -> { broadcast_remove_to self }
end
