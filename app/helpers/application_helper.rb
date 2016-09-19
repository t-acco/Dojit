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

  def will_helper(arr)

    htmlcode = ""

    (arr.num_of_pages).times do |index|
      if (arr[0].instance_of? Topic)
        if (arr.current_page == index)
          htmlcode += " #{index + 1}"
        else
          htmlcode += "<a href='#{arr[0].topics_path}?page=#{index}'>#{index + 1} </a>"
        end
      else
        htmlcode +=  "<a href='#{arr[0].topics_path}/#{arr[0].topic.id}?page=#{index}'>#{index + 1} </a>"
      end
    end

    htmlcode.html_safe
  end
end