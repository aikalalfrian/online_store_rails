json.message "User created successfully"
json.user do
  json.id @user.id
  json.email @user.email
  json.created_at @user.created_at
end
