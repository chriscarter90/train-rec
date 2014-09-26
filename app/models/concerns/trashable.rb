module Trashable
  extend ActiveSupport::Concern

  def trash
    update_attribute :trashed_at, Time.current
  end

  module ClassMethods
    def trashed
      unscoped {
        where("trashed_at IS NOT NULL")
      }
    end

    def untrashed
      scoped {
        where("trashed_at IS NULL")
      }
    end
  end
end
