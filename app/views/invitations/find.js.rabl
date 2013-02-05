collection @guests
attributes :id, :first_name, :last_name
child :answers do
  child(:question) { attributes :label }
  attributes :answer_text
end
