Owner.create(username: "The Pound Guy", password: "control them beasts")
Park.create(name: "The Pound", location: "123 Doggo Lane", owner: Owner.find_by_username("The Pound Guy"))
Pet.create(name: "Scruffy", color: "Brown", breed: "Mutt", owner: Owner.find_by_username("The Pound Guy"), park: Park.find_by_name("The Pound"))