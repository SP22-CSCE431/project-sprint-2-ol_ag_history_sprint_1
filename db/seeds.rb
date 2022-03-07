Admin.create!([
  {email: "writchie3@tamu.edu", full_name: "Walter Ritchie", uid: "106113943716370654381", avatar_url: "https://lh3.googleusercontent.com/a/AATXAJxn3RlhpP0rCiIfsefuC00GQ7YrKWfDr1Nw7t5v=s96-c"}
])
Member.create!([
  {fname: "Walter", lname: "Ritchie", joinDate: "2022-03-04", email: "writchie3@tamu.edu", phoneNumber: "2148936415", city: "College Station", admin: true, major: "Computer Science", active: true, gradDate: "2022-03-04"},
  {fname: "CJ", lname: "Sewell", joinDate: nil, email: "c.j.sewell07@tamu.edu", phoneNumber: "", city: "", admin: true, major: "Computer Engineering", active: true, gradDate: nil},
  {fname: "Anna", lname: "Kolodziejcyk", joinDate: nil, email: "akk962@tamu.edu", phoneNumber: "", city: "", admin: true, major: "", active: true, gradDate: nil},
  {fname: "Alex", lname: "Torres", joinDate: nil, email: "robincrass@tamu.edu", phoneNumber: "", city: "", admin: true, major: "", active: false, gradDate: nil},
  {fname: "Andrew", lname: "Arzola", joinDate: nil, email: "andrew.j.arzola@tamu.edu", phoneNumber: "", city: "", admin: true, major: "", active: false, gradDate: nil}
])
