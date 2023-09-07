class GetNearestAvailabilitiesSerializer < ActiveModel::Serializer
  attributes :list, :current_page, :current_count, :total_pages, :total_count

  has_many :list, serializer: CarparkSerializer
end
