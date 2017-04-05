require 'rails_helper'

RSpec.describe KiwiImage do
  include_context 'a kiwi image xml'

  let(:kiwi_image) { KiwiImage.from_xml(kiwi_xml) }

  describe '#from_xml' do
    subject { kiwi_image }

    it 'parses the xml into a KiwiImage model' do
      expect(subject.name).to eq('Christians_openSUSE_13.2_JeOS')
      expect(subject.description.author).to eq('Christian Bruckmayer')
      expect(subject.packages.type).to eq('image')
      expect(subject.packages.package[0].name).to eq('e2fsprogs')
      expect(subject.packages.package[1].name).to eq('aaa_base')
      expect(subject.packages.package[2].name).to eq('branding-openSUSE')
    end
  end

  describe '#to_xml' do
    subject { kiwi_image.to_xml }

    it 'exports the kiwi image to an xml string' do
      is_expected.to be_a String
    end
  end
end
