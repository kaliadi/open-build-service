require_dependency 'document'

class KiwiImage < Document
  class Description < Document
    attribute :type, String
    attribute :author, String
    attribute :contact, String
    attribute :specification, String
  end

  class Package < Document
    attribute :name, String
    attribute :bootinclude, Boolean

    validates_presence_of :name
    validate :package_exists_in_db

    def package_exists_in_db
      errors.add(:name) unless ::Package.exists?(name: name)
    end
  end

  class PackageCollection < Document
    attribute :type, String
    attribute :patternType, String
    attribute :package, Array[Package]
  end

  class Source < Document
    attribute :path, String
  end

  class Repository < Document
    attribute :type, String
    attribute :source, Source
  end

  attribute :name, String
  attribute :displayname, String
  attribute :schemaversion, String
  attribute :description, Description
  attribute :packages, PackageCollection
  attribute :repository, Array[Repository]

  validates_presence_of :name
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
end
