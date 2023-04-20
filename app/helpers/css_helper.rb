module CssHelper
  def show_css
    if !current_admin.Admin?
      'd-none'
    end

  end
  
end
