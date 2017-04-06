require 'rails_helper'

RSpec.describe Webui::KiwiImagesController do
  include_context 'a kiwi image xml'

  let(:user) { create(:confirmed_user) }
  let(:package) { create(:package, project: user.home_project) }

  describe "GET show" do
    it 'assigns a kiwi image' do
      allow(package).to receive(:source_file).with('kiwi_config.xml').
        and_return(kiwi_xml)
    end
  end
end
