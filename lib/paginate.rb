module Paginate
  
  attr_reader :num_of_pages, :current_page

  def paginate att
    page = att[:page] || 0
    per_page = att[:per_page]
    offset = page.to_i * per_page.to_i
    puts offset
    puts "------------------------"

    @num_of_pages = self.all.length / per_page.to_i + 1
    @current_page = page
    arr_to_show = self.limit(per_page).offset(offset)
    arr_to_show
  end
end