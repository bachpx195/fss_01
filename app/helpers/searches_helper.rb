module SearchesHelper
  def sort_keys
    {
      t("search.sort_by_time") => "time",
      t("search.sort_by_view") => "view",
      t("search.sort_by_like") => "like",
      t("search.sort_by_vote") => "vote"
    }
  end

  def category_keys
    if params.has_key?(:categories)
      keys = params[:categories].values.reject { |c| c.empty? }.map(&:to_i)
      return keys if keys.count > 0
    end
  end

  def search_keyword
    params[:q][:name_or_description_cont] if params.has_key?(:q)
  end
end
