puts "Destroying all previous records..."
User.destroy_all
Section.destroy_all
Subject.destroy_all
Classroom.destroy_all

puts "Creating Teachers..."
ada = Teacher.create!(first_name: "Ada", last_name: "Lovelace")
marie = Teacher.create!(first_name: "Marie", last_name: "Curie")
nikola = Teacher.create!(first_name: "Nikola", last_name: "Tesla")

puts "Creating Students..."
alan = Student.create!(first_name: "Alan", last_name: "Turing")
grace = Student.create!(first_name: "Grace", last_name: "Hopper")

puts "Creating Subjects..."
cs101 = Subject.create!(name: "Computer Science 101")
chem1 = Subject.create!(name: "General Chemistry I")
phys201 = Subject.create!(name: "University Physics II")

puts "Creating Classrooms..."
hopper_hall = Classroom.create!(name: "Hopper Hall 105")
turing_auditorium = Classroom.create!(name: "Turing Auditorium")
curie_lab = Classroom.create!(name: "Curie Lab 303")

puts "Creating Sections..."
section_cs_mwf = Section.create!(
  subject: cs101,
  teacher: ada, # Assign the teacher object directly
  classroom: turing_auditorium,
  start_time: "2000-01-01 08:00:00",
  end_time: "2000-01-01 08:50:00",
  days: "MWF"
)

section_chem_mwf = Section.create!(
  subject: chem1,
  teacher: marie,
  classroom: curie_lab,
  start_time: "2000-01-01 09:00:00",
  end_time: "2000-01-01 09:50:00",
  days: "MWF"
)

section_phys_tth = Section.create!(
  subject: phys201,
  teacher: nikola,
  classroom: hopper_hall,
  start_time: "2000-01-01 10:00:00",
  end_time: "2000-01-01 11:20:00", # 80-minute class
  days: "TTh"
)

# Enroll students in sections
puts "Enrolling students..."
Enrollment.create!(user: alan, section: section_cs_mwf)
Enrollment.create!(user: alan, section: section_phys_tth)
Enrollment.create!(user: grace, section: section_chem_mwf)
Enrollment.create!(user: grace, section: section_phys_tth)

puts "✅ Seeding complete!"
