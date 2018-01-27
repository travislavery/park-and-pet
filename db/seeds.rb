Owner.create(username: "The Pound Guy", password: "control them beasts")
Owner.create(username: "The Hospital Guy", password: "fix them beasts")
Park.create(name: "The Pound", location: "123 Doggo Lane", owner: Owner.find_by_username("The Pound Guy"))
Pet.create(name: "Scruffy", color: "Brown", breed: "Mutt", age: "old enough", adoptable: true, owner: Owner.find_by_username("The Pound Guy"), park: Park.find_by_name("The Pound"))
Park.create(name: "Doggo Hospital", location: "32 Doggo Lane", owner: Owner.find_by_username("The Hospital Guy"))