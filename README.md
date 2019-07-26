# Blog API 

Simple blog api with dry-monads, representers, commands

## API methods 
### 1. Articles
##### 1.1 Create 

```
method: "POST"
path:   "/api/v1/articles"
params: article_params[title], article_params[text], login
```
##### 1.2 Top articles
```
method: "GET"
path:   "/api/v1/articles/top/:top_count"
```
##### 1.3 Get articles with same ip but different user 
```
method: "GET"
path:   "/api/v1/articles/with_same_ip_different_user"
```
### 2. Rates
##### 2.1 Create
```
method: "POST"
path:   "/api/v1/articles/:article_id/rates"
params: rate_params["rate"]
```

## For start
```
git clone https://github.com/m0rozov/blog
bundle install
rails db:create 
rails db:migrate
```
For create random data use `rails db:seed`. 
It generate 200_000 articles, 100 users with 50 ip and 100_000 rates


