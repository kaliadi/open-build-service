require 'rails_helper'

RSpec.describe KiwiImage do
  include_context 'a kiwi image xml'

  let(:kiwi_image) { KiwiImage.from_xml(kiwi_xml) }

  describe '#from_xml' do
    subject { kiwi_image }

    it 'parses the repository elements of the xml into a KiwiImage model' do
      expect(subject.repository[0].source.path).to eq('http://download.opensuse.org/update/13.2/')
      expect(subject.repository[1].source.path).to eq('http://download.opensuse.org/distribution/13.2/repo/oss/')
      expect(subject.repository[0].type).to eq('rpm-md')
      expect(subject.repository[1].type).to eq('rpm-md')
    end
  end

  describe '#to_xml' do
    subject { kiwi_image.to_xml }

    it 'exports the kiwi image to an xml string' do
      is_expected.to be_a String
    end
  end
end
