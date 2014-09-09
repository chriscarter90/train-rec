module Trashable
  extend ActiveSupport::Concern

  included do
    default_scope { where("trashed_at IS NULL") }
  end

  def trash
    update_attribute :trashed_at, Time.current
  end

  module ClassMethods
    def trashed
      unscoped {
        where("trashed_at IS NOT NULL")
      }
    end
  end
end
