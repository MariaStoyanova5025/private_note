json.extract! note, :id, :msg, :url, :created_at, :updated_at
json.url note_url(note, format: :json)
