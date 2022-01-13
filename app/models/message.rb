class Message < ApplicationRecord
  validates_uniqueness_of :content

  after_create_commit { broadcast_append_to "messages" }

end
