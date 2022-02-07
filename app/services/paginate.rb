class Paginate

  def self.call(model, count_page)
  debugger
    Kaminari.paginate_array(model).page(params[:page]).per(count_page)
  end
end