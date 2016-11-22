class MoveCommentsData < ActiveRecord::Migration[5.0]
  def change
    Comment.inheritance_column = nil
    puts 'holaaa: ' + Comment.where("type IS NOT NULL").count.to_s
    Comment.where("type IS NOT NULL").find_each(batch_size: 5000) do |comment|
      /\AComment(?<type>.+)/ =~ comment.type
      puts type.nil?
      raise Exception unless type
      comment.commentable_type = type
      comment.commentable_id = comment.project_id || comment.package_id || comment.bs_request_id
      comment.type = comment.project_id = comment.package_id = comment.bs_request_id = nil
      comment.save!
    end
    Comment.inheritance_column = 'type'
  end
end
