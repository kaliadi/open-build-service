namespace :data do
  desc 'Move comments to the children tables to make Comment abstract'

  task make_comment_abstract: :environment do
    comment_projects = Comment.where(type: 'comment_project')
    comment_packages = Comment.where(type: 'comment_package')
    comment_requests = Comment.where(type: 'comment_request')
    
    Comment.abstract_class = true
    puts 'Comment class is now abstract!'
    
    CommentProject << comment_projects
    CommentPackage << comment_packages
    CommentRequest << comment_requests
    puts 'Comments have been moved to the children tables'
  end
end