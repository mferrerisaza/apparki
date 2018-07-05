# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ticket.destroy_all
ParkingZone.destroy_all
User.destroy_all
Vehicle.destroy_all

def randomize_plate
  letters = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
  numbers = %w[1 2 3 4 5 6 7 8 9 0]
  plate = ""
  3.times do
    letter = letters.sample
    plate << letter
  end

  3.times do
    number = numbers.sample
    plate << number
  end
  plate
end

def randomize_vehicle
  offset = rand(Vehicle.count)
  Vehicle.offset(offset).first
end

p "Empezando..."
p "Creando Usuarios"

u1 = User.new(
  email: "dan@gmail.com",
  password: "123456",
  )
u1.save!

p "Usuario 1 creado"
u2 = User.new(
  email: "mike@gmail.com",
  password: "123456",
  )
p "Usuario 2 creado"
u2.save!

u3 = User.new(
  email: "test@gmail.com",
  password: "123456",
  )
p "Usuario prueba creado"
u3.save!

p "Creando Zonas de parqueo"

z1 = ParkingZone.new(
  name: "Zona 1",
  city: "El Retiro",
  user: u1,
  price: 3000
  )
z1.save!

p "Zona de parqueo 1 creada"

z2 = ParkingZone.new(
  name: "Zona 2",
  city: "El Retiro",
  user: u1,
  price: 3000
  )
z2.save!

p "Zona de parqueo 1 creada"

z3 = ParkingZone.new(
  name: "Zona 3",
  city: "El Retiro",
  user: u2,
  price: 3000
  )
z3.save!

p "Zona de parqueo 3 creada"

p "Creando Vehículos"

60.times do |t|
  v = "v#{t}"
  v = Vehicle.new(
  plate: randomize_plate
  )
  p "Vehiculo #{t} creado"
  v.save!
end

t1 = Ticket.new(
  entry: (Time.zone.now - 2.hours),
  status: "pendiente",
  vehicle: randomize_vehicle,
  parking_zone: z1,
  entry_user: u1,
  )
t1.save!
p "Ticket 1 creado #{t1.charge}"

t2 = Ticket.new(
  entry: (Time.zone.now - 1.hours),
  status: "pendiente",
  vehicle: randomize_vehicle,
  parking_zone: z2,
  entry_user: u1,
  )
t2.save!
p "Ticket 2 creado #{t2.charge}"

t3 = Ticket.new(
  entry: (Time.zone.now - 2.hours),
  exit: (Time.zone.now),
  status: "pagado",
  vehicle: randomize_vehicle,
  parking_zone: z3,
  entry_user: u1,
  exit_user: u2,
  charge: 4000,
  )
t3.save!
p "Ticket 3 creado #{t3.charge}"

t4 = Ticket.new(
  entry: (Time.zone.now - 2.hours),
  exit: (Time.zone.now - 1.hours),
  status: "pagado",
  vehicle: randomize_vehicle,
  parking_zone: z3,
  entry_user: u1,
  exit_user: u2,

  charge: 2000,
  )
t4.save!
p "Ticket 4 creado #{t4.charge}"

400.times do |time|
  entry = rand(0..2160)
  hours = rand(1..6)
  t = Ticket.new(
  entry: (Time.zone.now - entry.hours),
  exit: (Time.zone.now - entry.hours + hours.hours),
  status: "pagado",
  vehicle: randomize_vehicle,
  parking_zone: [z1, z2, z3, z3].sample,
  entry_user: u1,
  exit_user: u2,

  charge: 2000 * hours,
  )
  if t.save
    p "Ticket #{time + 5} creado #{t.charge}"
  else
    p "Ticket #{time + 5} NO creado"
  end
end


10.times do |time|
  entry = rand(0..480)
  hours = rand(1..6)
  t = Ticket.new(
  entry: (Time.zone.now - entry.hours),
  exit: (Time.zone.now - entry.hours + hours.hours),
  status: "reportado",
  vehicle: randomize_vehicle,
  parking_zone: [z1, z2, z3, z3].sample,
  entry_user: u1,
  exit_user: u2,

  charge: 2000 * hours,
  )
  if t.save
    p "Ticket #{time + 405 } creado #{t.charge}"
  else
    p "Ticket #{time + 405 } NO creado"
  end
end

10.times do |time|
  entry = rand(0..5)
  hours = rand(1..6)
  t = Ticket.new(
  entry: (Time.zone.now - entry.hours),
  # exit: (Time.zone.now - entry.hours + hours.hours),
  status: "pendiente",
  vehicle: randomize_vehicle,
  parking_zone: [z1, z2, z3, z3].sample,
  entry_user: u1,
  exit_user: u2,
  charge: 2000 * hours,
  )
  if t.save
    p "Ticket #{time + 414 }"
  else
    p "Ticket #{time + 414 } NO creado"
  end
end

t = Ticket.new(
  entry: (Time.zone.now),
  exit: (Time.zone.now + 2.hours),
  status: "pagado",
  parking_zone: z1,
  entry_user: u3,
  exit_user: u1,
  vehicle: randomize_vehicle,
  charge: 2000 * 2,
  )
if t.save
  p "Ticket de prueba creado #{t.charge}"
else
  p "Ticket de prueba NO creado"
end

t = Ticket.new(
  entry: (Time.zone.now),
  exit: (Time.zone.now + 2.hours),
  status: "pagado",
  parking_zone: z1,
  entry_user: u1,
  exit_user: u3,
  vehicle: randomize_vehicle,
  charge: 2000 * 2,
  )
if t.save
  p "Ticket de prueba creado #{t.charge}"
else
  p "Ticket de prueba NO creado"
end
