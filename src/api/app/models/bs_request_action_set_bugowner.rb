#
class BsRequestActionSetBugowner < BsRequestAction
  def self.sti_name
    :set_bugowner
  end

  def check_sanity
    super
    return unless person_name.blank? && group_name.blank?
    errors.add(:person_name, 'Either person or group needs to be set')
  end

  def execute_accept(_opts)
    object = Project.find_by_name(target_project)
    object = object.packages.find_by_name(target_package) if target_package

    object.relationships.where('role_id = ?', role_object).find_each(&:destroy)

    object.add_user(person_name, role_object, true) if person_name # runs with ignoreLock
    object.add_group(group_name, role_object, true) if group_name  # runs with ignoreLock

    object.store(comment: "set_bugowner request #{bs_request.number}", request: bs_request)
  end

  def render_xml_attributes(node)
    render_xml_target(node)
    node.person name: person_name if person_name
    node.group name: group_name if group_name
  end

  private

  def role_object
    @role_object = Role.find_by_title!('bugowner')
  end
end

# == Schema Information
#
# Table name: bs_request_actions
#
#  id                    :integer          not null, primary key
#  bs_request_id         :integer          indexed, indexed => [target_package_id], indexed => [target_project_id]
#  type                  :string(255)
#  target_project        :string(255)      indexed
#  target_package        :string(255)      indexed
#  target_releaseproject :string(255)
#  source_project        :string(255)      indexed
#  source_package        :string(255)      indexed
#  source_rev            :string(255)
#  sourceupdate          :string(255)
#  updatelink            :boolean          default(FALSE)
#  person_name           :string(255)
#  group_name            :string(255)
#  role                  :string(255)
#  created_at            :datetime
#  target_repository     :string(255)
#  makeoriginolder       :boolean          default(FALSE)
#  target_package_id     :integer          indexed => [bs_request_id], indexed
#  target_project_id     :integer          indexed => [bs_request_id], indexed
#
# Indexes
#
#  bs_request_id                                                    (bs_request_id)
#  index_bs_request_actions_on_bs_request_id_and_target_package_id  (bs_request_id,target_package_id)
#  index_bs_request_actions_on_bs_request_id_and_target_project_id  (bs_request_id,target_project_id)
#  index_bs_request_actions_on_source_package                       (source_package)
#  index_bs_request_actions_on_source_project                       (source_project)
#  index_bs_request_actions_on_target_package                       (target_package)
#  index_bs_request_actions_on_target_package_id                    (target_package_id)
#  index_bs_request_actions_on_target_project                       (target_project)
#  index_bs_request_actions_on_target_project_id                    (target_project_id)
#
# Foreign Keys
#
#  bs_request_actions_ibfk_1  (bs_request_id => bs_requests.id)
#
