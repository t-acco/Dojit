module ApplicationHelper
  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extension = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extension)
    (redcarpet.render text).html_safe
  end

  def my_name
    "Tom"
  end

  def vote_link_classes(post, dir)

    if (dir == 'up')
      "glyphicon glyphicon-chevron-up #{(current_user.voted?(post) && current_user.voted?(post).up_vote?) ? 'voted' : ''}"
    else
      "glyphicon glyphicon-chevron-down #{(current_user.voted?(post) && current_user.voted?(post).down_vote?) ? 'voted' : ''}"
    end
  end
end