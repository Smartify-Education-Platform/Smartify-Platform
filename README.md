# Smartify Platform — Educational Platform for High School Students

**Smartify** is an all-in-one educational platform that helps Russian high school students (grades 9–11) navigate their career path, choose the right university, prepare for the Unified State Exam (ЕГЭ), and find suitable tutors.  
The key feature is **AI-based personalized recommendations** that make the journey clear and accessible for every student.

## 🔥 Key Advantages

- **All-in-one solution** — no need to juggle multiple websites and tools  
- **Personalized guidance** — specific career suggestions, not just general directions  
- **Accessible and clear** — recommendations based on student interests, scores, and goals  

---

## 🧩 Application Modules

### 1. 🔍 Career Guidance Module

- Interactive questionnaire covering interests, school performance, and hobbies  
- AI-powered analysis suggests **specific careers** (e.g., _pediatric surgeon_ instead of just _medic_)  
- Shows required subjects for admission right away  
- Includes reasoning behind the career choice to help students understand the fit

---

### 2. 🎓 University Selection Module

- Filter universities by region, tuition (budget/paid), and field of study  
- Compare universities by:
  - Entrance scores
  - Education costs
  - National rankings

---

### 3. 📚 Exam Preparation Module

- Based on the chosen career and university, recommends:
  - Required subjects
  - Weekly study plan (hours per subject)
- Built-in mini-tests to assess current knowledge  
- Progress tracker to monitor preparation

---

### 4. 👩‍🏫 Tutors Module

- Find tutors using flexible filters:
  - Subject
  - Teaching style (e.g., friendly, strict, structured)
- Browse detailed tutor profiles, including:
  - Background and experience
  - University they attended
  - etc.

---

## 🧠 Powered by AI

We use AI not just for buzz — but for real insights:
- Matching careers with individual traits
- Recommending optimal universities
- Dynamically adjusting preparation plans

---

## 🚀 Launching the app

Clone repository locally:
   ```sh
   git clone https://github.com/Smartify-Education-Platform/Smartify-Platform.git
   ```
Starting the app:
   ```sh
   cd Smartify-Platform/frontend
   flutter run
   ```

---

## 📸 Screenshots of the key features

![Main page](assets/main_page.png)
![Universities](assets/universities.png)
![Task tracker](assets/task_tracker.png)
![Questionnaire](assets/questionnaire.png)
![Tutors](assets/tutors.png)

---

## 📑 API Documentation

[Here](http://213.226.112.206:22025/swagger/index.html) is swagger documentation for our project

---

## 🔭 Architecture diagrams and explanations

## ER Diagram: users and refresh_tokens

![ER Diagram](assets/SQL.png)

This diagram represents the data model for a user authentication system, consisting of two tables: users and refresh_tokens.

### Entities

#### users
- Stores user account details.
- Key fields:
  - id: Unique user ID (Primary Key).
  - email: User's email address, unique and validated with a regex pattern.
  - password_hash: Hashed password.
  - first_name, last_name, middle_name: User’s name information.
  - date_of_birth: User’s date of birth, must be later than 1900-01-01.
  - created_at: Timestamp when the user was created.
  - last_login: Timestamp of the user’s last login.
  - is_active: Indicates whether the user account is active.
  - user_role: Role of the user (student, tutor, or administrator).

#### refresh_tokens
- Stores refresh tokens used for session management and re-authentication.
- Key fields:
  - id: Unique token record ID (Primary Key).
  - user_id: Foreign key referencing users.id.
  - token: The refresh token string.
  - expires_at: When the token expires.
  - created_at: When the token was created.

### Relationships
- users.id → refresh_tokens.user_id  
  One user can have multiple refresh tokens (one-to-many relationship).

---

## PlantUML Diagram: Database Domain Model

![PlantUML Diagram](assets/MongoDB.png)

This UML diagram describes domain entities used in the system, representing a data model for educational and career recommendations.

### Entities

#### University
- Represents a university entity.
- Fields:
  - ID: Unique university identifier.
  - Name, Country: University details.
  - TimeStamp: Record creation/update time.
  - ExtraData: Additional data as a flexible key-value store.

#### UniversityMongo
- An extended university entity with additional fields for storing information from MongoDB.
- Fields include:
  - Link, Region, City
  - FoundationYear, Dormitory
  - Various flags like IsState, IsAccredited
  - Ratings, student counts, price information
  - Contact details like Phone and Address
  - Lists like Faculties and maps like PassingScores

#### Profession
- Describes a profession.
- Fields:
  - Name, Description
  - EgeSubjects, MBTITypes
  - Interests, Values
  - Role, Place, Style
  - EducationLevel, SalaryRange
  - GrowthProspects
  - TimeStamp

#### Questionnaire
- Captures user questionnaire data for career guidance.
- Fields:
  - UserID: Associated user.
  - School class, region, average grade
  - Lists of favorite and difficult subjects
  - SubjectScores: Map of subjects to scores
  - Interests, Values
  - MBTIScores: Map of MBTI results
  - Embedded object: WorkPreferences
  - TimeStamp

#### WorkPreferences
- Embedded within Questionnaire.
- Fields:
  - Role, Place, Style, Exclude

#### ProfessionRec
- Stores profession recommendations for users.
- Fields:
  - UserID
  - List of predicted professions: ProfessionPredic
  - TimeStamp

#### ProfessionPredic
- Represents an individual predicted profession.
- Fields:
  - Name, Score
  - Positive and negative aspects
  - Description
  - Subsphere

#### Tutor
- Captures data about tutors.
- Fields:
  - UserID
  - Cource (likely intended as “Course”)
  - List of universities
  - Interests
  - TimeStamp

#### User_trackers
- Stores tracking information for users.
- Fields:
  - UserID
  - Trackers: list of trackers
  - TimeStamp

#### Teacher
- Represents information about a teacher.
- Fields:
  - Name, Subject
  - Level, Price
  - City, Rating
  - AvatarURL, Link
  - TimeStamp

### Relationships

- Questionnaire → WorkPreferences  
  A Questionnaire contains exactly one WorkPreferences object.

- ProfessionRec → ProfessionPredic  
  A ProfessionRec contains multiple predicted professions.

---

## Implementation checklist

### Technical requirements (20 points)
#### Backend development (8 points)
- [x] Go-based backend (3 points)
- [x] RESTful API with Swagger documentation (2 point)
- [x] PostgreSQL database with proper schema design (1 point)
- [x] JWT-based authentication and authorization (1 point)
- [x] Comprehensive unit and integration tests (1 point)

#### Frontend development (7 points)
- [x] Flutter-based cross-platform application (mobile + web) (3 points)
- [x] Responsive UI design with custom widgets (1 point)
- [x] State management implementation (1 point)
- [x] Offline data persistence (1 point)
- [ ] Unit and widget tests (1 point)
- [x] Support light and dark mode (1 point)

#### DevOps & deployment (4 points)
- [x] Docker compose for all services (1 point)
- [x] CI/CD pipeline implementation (1 point)
- [x] Environment configuration management using config files (1 point)
- [x] GitHub pages for the project (1 point)

### Non-Technical Requirements (10 points)
#### Project management (4 points)
- [x] GitHub organization with well-maintained repository (1 point)
- [x] Regular commits and meaningful pull requests from all team members (1 point)
- [x] Project board (GitHub Projects) with task tracking (1 point)
- [x] Team member roles and responsibilities documentation (1 point)

#### Documentation (4 points)
- [x] Project overview and setup instructions (1 point)
- [x] Screenshots and GIFs of key features (1 point)
- [x] API documentation (1 point)
- [x] Architecture diagrams and explanations (1 point)

#### Code quality (2 points)
- [x] Consistent code style and formatting during CI/CD pipeline (1 point)
- [x] Code review participation and resolution (1 point)

### Bonus Features (up to 10 points)
- [x] Localization for Russian (RU) and English (ENG) languages (2 points)
- [x] Good UI/UX design (up to 3 points)
- [ ] Integration with external APIs (fitness trackers, health devices) (up to 5 points)
- [x] Comprehensive error handling and user feedback (up to 2 points)
- [x] Advanced animations and transitions (up to 3 points)
  - Center card: Scales up (appears larger)
  - Side cards: Scale down (appear smaller)
  - Transition: Smooth scaling as you swipe, thanks to the animation curve
  - This animation enhances the user experience by making the carousel interactive and visually appealing, emphasizing the currently selected favorite university
- [x] Widget implementation for native mobile elements (up to 2 points)
  - CupertinoButton
  - CupertinoAlertDialog
  - CupertinoTextField and so on
- [x] Recomendation system implementation for quesionnaire


Total points implemented: 29/30 (excluding bonus points)

  > Helping students make informed decisions — simply, clearly, and effectively.  
**Smartify: Your personalized guide to the future.**
