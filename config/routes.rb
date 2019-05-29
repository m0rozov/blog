Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'articles/with_same_ip_different_user', to: 'articles#articles_with_same_ip_different_user',
                                                  as: 'api_v1_articles_with_same_ip_different_user'
      get 'articles/top/:top_count', to: 'articles#top_articles', as: 'api_v1_top_articles'
      post 'articles', to: 'articles#create', as: 'api_v1_articles_create'
      post 'articles/:article_id/rates', to: 'articles/rates#create', as: 'api_v1_create_rate'
    end
  end
end
