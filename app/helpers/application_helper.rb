# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def author
    @author ||= Struct.new(:name, :email).new(config[:author][:name], config[:author][:email])
  end
  
  def description
    config[:description]
  end
  
  def meta_keyword_tags
    Tag.all(:limit => 5, :order => 'taggings_count DESC').map(&:name).join(',')
  end

  def open_id_delegation_link_tags(server, delegate)
    links = <<-EOS
      <link rel="openid.server" href="#{server}" />
      <link rel="openid.delegate" href="#{delegate}" />
    EOS
  end
  
  def format_comment_error(error)
    {
      'question' => 'Question was not answered correctly',
      'body'   => 'Please comment',
      'author' => 'Please provide your name or OpenID identity URL',
      'base'   => error.last
    }[error.first]
  end
end
