module CssHelper
  def showCss
    if !current_admin.Admin?
      'd-none'
    end

  end
  
end
