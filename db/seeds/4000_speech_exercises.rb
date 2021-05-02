puts "Seeding speech exercises..."

def read_base64_file(file)
  return nil unless file

  # TODO handle mime type
  File.open(Rails.root.join('db', 'seeds', 'images', file), 'rb') do |img|
    "data:image/png;base64,#{Base64.strict_encode64(img.read)}"
  end
end

speech_exercise_data = {
  'gato' => 'cat.png',
  'cocodrilo' => 'crocodile.png',
  'perro' => 'dog.png',
  'elefante' => 'elephant.png',
  'raton' => 'mouse.png',
  'búho' => 'owl.png',
  'chancho' => 'pig.png',
  'tortuga' => 'turtle.png',
  'jirafa' => nil,
  'murcielago' => nil,
  'auto rojo' => nil,
  'camión verde' => nil,
  'cha cha cha' => nil,
  'campera marrón' => nil,
}

speech_exercises = []

speech_exercise_data.each do |sentence, image|
  speech_exercises << Exercise.create(
    exercise_type: Exercise::EXERCISE_TYPE_SPEECH,
    name: sentence.capitalize,
    description: "Presione el bóton y pronuncie \"#{sentence.capitalize()}\".",
    steps: [
      {
        goal: sentence,
        image: read_base64_file(image)
      },
    ].to_json
  )
end