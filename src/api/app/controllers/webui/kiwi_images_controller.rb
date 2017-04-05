class Webui::KiwiImagesController < Webui::WebuiController
  before_action :set_project
  before_action :require_package

  def show
    kiwi_xml = @package.source_file('kiwi_config.xml', {})
    @kiwi_image = KiwiImage.from_xml(kiwi_xml)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
