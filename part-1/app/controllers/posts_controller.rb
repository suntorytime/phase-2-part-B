get "/posts" do
  @posts = Post.all
  erb :'posts/index'
end

post "/posts" do
  @post = Post.new(params[:post])

  if @post.save
    redirect "posts/#{@post.id}"
  end
end

get "/posts/new" do
  @post = Post.new
  erb :'posts/new'
end

get "/posts/:id" do
  @post = Post.find(params[:id])
  erb :'posts/show'
end
