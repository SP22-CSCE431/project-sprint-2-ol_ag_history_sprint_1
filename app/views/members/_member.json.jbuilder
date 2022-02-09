json.extract! member, :id, :memberID, :fname, :lname, :joinDate, :gradeDate, :email, :phoneNumber, :city, :admin, :major, :password, :created_at, :updated_at
json.url member_url(member, format: :json)
