Card.destroy_all
Relation.destroy_all
Transaction.destroy_all
User.destroy_all
#Users
j = User.create(name: "Jesus E.", username: "eyisus", password: "1234", balance: 10000, image: "eyisus.png")
v = User.create(name: "Veronica Y.", username: "vero", password: "1234", balance: 5000, image: "vero.png")
pat = User.create(name: "Patricio C.", username: "pat", password: "1234", image: "pat.jpg")
frank = User.create(name: "Frank K.", username: "frank", password: "1234", balance: 3000, image: "frank.png")

Card.create(user: j, card_number: "4287123973598366", security_code: 600, card_type: "visa", zip_code: 33178, exp_date: DateTime.strptime("02/2019", "%m/%Y"))
#transactions
t1 = Transaction.create(sender: j, receiver: v, amount: 200, message: "For you my love 😍 💵💸")
t2 = Transaction.create(sender: pat, receiver: j, amount: 500, message: "All my 💵💸")
t3 = Transaction.create(sender: frank, receiver: pat, amount: 2000, message: "Thanks for the 🌮")
t4 = Transaction.create(sender: frank, receiver: v, amount: 500, message: "Great concert! 🎻🎶")
t5 = Transaction.create(sender: j, receiver: pat, amount: 2300, message: "🐶🐱There you go bro🤩")
t6 = Transaction.create(sender: v, receiver: pat, amount: 1000, message: "🍕Awesome pizza night🍕")
#Friendships
r1 = Relation.create(follower:j, followed:v)
r2 = Relation.create(follower:j, followed:pat)
r3 = Relation.create(follower:pat, followed:v)
r4 = Relation.create(follower:frank, followed:j)
r5 = Relation.create(follower:v, followed:j)
r6 = Relation.create(follower:pat, followed:j)
r7 = Relation.create(follower:v, followed:pat)
r8 = Relation.create(follower:frank, followed:v)