module ApplicationHelper
def sort_class(column_name)
    params[:sort] == column_name ? "hilite" : ""
  end
end

