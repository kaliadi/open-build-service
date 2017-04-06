require_dependency 'document'

class KiwiImage < Document
  class Source < Document
    attribute :path, String
  end

  class Repository < Document
    attribute :type, String
    attribute :source, Source
  end

  attribute :repository, Array[Repository]
  alias_method :repositories, :repository

  validate :no_duplicate_repositories

  def no_duplicate_repositories
    repository.each do |repo1|
      repository.each do |repo2|
        if repo1 == repo2
          errors.add(:base, 'no duplicate repos')
          return
        end
      end
    end
  end

  def self.from_xml(xml)
    xml_hash = Xmlhash.parse(xml)
    new(xml_hash.slice("repository"))
  end
end
