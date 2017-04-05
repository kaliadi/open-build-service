class Document
  include Virtus.model
  include ActiveModel::Model

  def self.from_xml(xml)
    xml_hash = Xmlhash.parse(xml)
    new(xml_hash)
  end

  def to_xml
    self.to_hash.to_xml
  end

  protected

  # Override Virtus' to_hash method becuase it isn't recursive
  # See this discussion for more info: https://github.com/solnic/virtus/pull/83
  def to_hash
    VirtusConvert.new(self).to_hash
  end
end
