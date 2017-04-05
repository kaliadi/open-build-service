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

  attribute :name, String
  attribute :displayname, String
  attribute :schemaversion, String
  attribute :description, Description
  attribute :packages, PackageCollection

  validates_presence_of :name
end
