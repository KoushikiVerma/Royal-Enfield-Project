from flask import Flask, render_template, request, redirect, session
import mysql.connector

app = Flask(__name__)
app.secret_key = "secret123"

# DB CONNECTION
def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="royalenfielddb"
    )

# HOME
@app.route('/')
def home():
    return render_template('index.html')

# ABOUT
@app.route('/about')
def about():
    return render_template('about.html')

# CONTACT
@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            "INSERT INTO contact (name, email, message) VALUES (%s, %s, %s)",
            (request.form['name'], request.form['email'], request.form['message'])
        )
        conn.commit()
        conn.close()
        return redirect('/contact')
    return render_template('contact.html')

@app.route('/manage_contact')
def manage_contact():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM contact")
    contacts = cursor.fetchall()
    conn.close()
    return render_template('manage_contact.html', contacts=contacts)

@app.route('/delete_contact/<int:id>')
def delete_contact(id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM contact WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect('/manage_contact')

@app.route('/feedback', methods=['GET', 'POST'])
def feedback():
    if request.method == 'POST':
        conn = get_db()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO feedback (name, email, message) VALUES (%s, %s, %s)",
            (request.form['name'], request.form['email'], request.form['message'])
        )
        conn.commit()
        conn.close()
        return redirect('/feedback')
    return render_template('feedback.html')


@app.route('/manage_feedback')
def manage_feedback():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM feedback")
    feedbacks = cursor.fetchall()
    conn.close()
    return render_template('manage_feedback.html', feedbacks=feedbacks)


@app.route('/delete_feedback/<int:id>')
def delete_feedback(id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM feedback WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect('/manage_feedback')

# SIGNUP
@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        try:
            conn = get_db()
            cursor = conn.cursor()
            cursor.execute(
                "INSERT INTO users (first_name, last_name, email, password, contact) VALUES (%s, %s, %s, %s, %s)",
                (request.form['first_name'], request.form['last_name'],
                 request.form['email'], request.form['password'],
                 request.form['contact'])
            )
            conn.commit()
            conn.close()
            return redirect('/userlogin')
        except mysql.connector.IntegrityError:
            return "Email already exists ❌"
    return render_template('signup.html')

# LOGIN
@app.route('/userlogin', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(
            "SELECT * FROM users WHERE email=%s AND password=%s",
            (request.form['email'], request.form['password'])
        )
        user = cursor.fetchone()
        conn.close()

        if user:
            session['user_id'] = user['id']
            session['user_name'] = user['first_name']
            return redirect('/userdashboard')
        return "Invalid Email or Password"

    return render_template('userlogin.html')

# DASHBOARD
@app.route('/userdashboard')
def userdashboard():
    if 'user_id' not in session:
        return redirect('/userlogin')
    return render_template('userdashboard.html')

# BIKES
@app.route('/bikes')
def bikes():
    if 'user_id' not in session:
        return redirect('/userlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM bikes")
    bikes = cursor.fetchall()
    conn.close()
    return render_template('bikes.html', bikes=bikes)


@app.route('/book/<int:id>', methods=['GET', 'POST'])
def book_bike(id):
    if 'user_id' not in session:
        return redirect('/userlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    # get bike
    cursor.execute("SELECT * FROM bikes WHERE id=%s", (id,))
    bike = cursor.fetchone()

    # get EMI options for this bike
    cursor.execute("SELECT * FROM emi WHERE bike_id=%s", (id,))
    emis = cursor.fetchall()

    if request.method == 'POST':
        name = request.form['name']
        contact = request.form['contact']
        address = request.form['address']
        plan = request.form['plan']
        months = request.form.get('months')  # EMI months

        cursor = conn.cursor()

        cursor.execute("""
            INSERT INTO bike_orders 
            (user_id, bike_id, name, contact, address, payment_type)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            session['user_id'],
            id,
            name,
            contact,
            address,
            plan if plan == "Full Payment" else f"EMI - {months} months"
        ))

        conn.commit()
        conn.close()

        return "<h1>Booking Request Sent ✅</h1>"

    conn.close()
    return render_template('book_bike.html', bike=bike, emis=emis)

# SERVICES
@app.route('/services')
def services():
    if 'user_id' not in session:
        return redirect('/userlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM services")
    services = cursor.fetchall()
    conn.close()
    return render_template('services.html', services=services)

@app.route('/book_service/<int:id>', methods=['GET', 'POST'])
def book_service(id):
    if 'user_id' not in session:
        return redirect('/userlogin')
    if request.method == 'POST':
        conn = get_db()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO bookings (user_id, service_id, name, contact, address, date) VALUES (%s, %s, %s, %s, %s, %s)",
            (session['user_id'], id,
             request.form['name'], request.form['contact'],
             request.form['address'], request.form['date'])
        )
        conn.commit()
        conn.close()
        return "<h1>Service Booked Successfully ✅</h1>"

    return render_template('book_service.html')

@app.route('/adminlogin', methods=['GET', 'POST'])
def adminlogin():
    if request.method == 'POST':
        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        cursor.execute(
            "SELECT * FROM admin WHERE email=%s AND password=%s",
            (request.form['username'], request.form['password'])
        )

        admin = cursor.fetchone()
        conn.close()

        if admin:
            session['admin'] = admin['id']
            return redirect('/admindashboard')

        return "Invalid Admin Credentials ❌"

    return render_template('adminlogin.html')

@app.route('/admindashboard')
def admindashboard():
    if 'admin' not in session:
        return redirect('/adminlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT COUNT(*) FROM bikes")
    bike_count = cursor.fetchone()['COUNT(*)']

    cursor.execute("SELECT COUNT(*) FROM services")
    service_count = cursor.fetchone()['COUNT(*)']

    cursor.execute("SELECT COUNT(*) FROM users")
    user_count = cursor.fetchone()['COUNT(*)']

    cursor.execute("SELECT COUNT(*) FROM bookings")
    booking_count = cursor.fetchone()['COUNT(*)']

    conn.close()

    return render_template('admindashboard.html',
                           bike_count=bike_count,
                           service_count=service_count,
                           user_count=user_count,
                           booking_count=booking_count)

@app.route('/manage_bikes', methods=['GET', 'POST'])
def manage_bikes():
    if 'admin' not in session:
        return redirect('/adminlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        cursor.execute(
            "INSERT INTO bikes (name, image, description, engine, mileage, price) VALUES (%s, %s, %s, %s, %s, %s)",
            (request.form['name'], request.form['image'],
             request.form['description'], request.form['engine'],
             request.form['mileage'], request.form['price'])
        )
        conn.commit()

    cursor.execute("SELECT * FROM bikes")
    bikes = cursor.fetchall()
    conn.close()

    return render_template('manage_bikes.html', bikes=bikes)


@app.route('/delete_bike/<int:id>')
def delete_bike(id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM bikes WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect('/manage_bikes')

@app.route('/manage_services', methods=['GET', 'POST'])
def manage_services():
    if 'admin' not in session:
        return redirect('/adminlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        cursor.execute(
            "INSERT INTO services (name, image, description, price) VALUES (%s, %s, %s, %s)",
            (request.form['name'], request.form['image'],
             request.form['description'], request.form['price'])
        )
        conn.commit()

    cursor.execute("SELECT * FROM services")
    services = cursor.fetchall()
    conn.close()

    return render_template('manage_services.html', services=services)


@app.route('/delete_service/<int:id>')
def delete_service(id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM services WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect('/manage_services')

@app.route('/view_bookings')
def view_bookings():
    if 'admin' not in session:
        return redirect('/adminlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    # 🔹 SERVICE BOOKINGS
    cursor.execute("""
        SELECT bookings.*, 
               CONCAT(users.first_name, ' ', users.last_name) AS user_name,
               services.name AS service_name
        FROM bookings
        JOIN users ON bookings.user_id = users.id
        JOIN services ON bookings.service_id = services.id
    """)
    service_bookings = cursor.fetchall()

    # 🔹 BIKE BOOKINGS
    cursor.execute("""
        SELECT bike_orders.*, 
               CONCAT(users.first_name, ' ', users.last_name) AS user_name,
               bikes.name AS bike_name
        FROM bike_orders
        JOIN users ON bike_orders.user_id = users.id
        JOIN bikes ON bike_orders.bike_id = bikes.id
    """)
    bike_bookings = cursor.fetchall()

    conn.close()

    return render_template(
        'view_bookings.html',
        service_bookings=service_bookings,
        bike_bookings=bike_bookings
    )



@app.route('/manage_users')
def manage_users():
    if 'admin' not in session:
        return redirect('/adminlogin')

    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM users")
    users = cursor.fetchall()

    conn.close()

    return render_template('manage_users.html', users=users)

@app.route('/delete_user/<int:id>')
def delete_user(id):
    if 'admin' not in session:
        return redirect('/adminlogin')

    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM users WHERE id=%s", (id,))
    conn.commit()
    conn.close()

    return redirect('/manage_users')

@app.route('/manage_emi', methods=['GET', 'POST'])
def manage_emi():
    if 'admin' not in session:
        return redirect('/adminlogin')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        bike_id = request.form['bike_id']
        months = int(request.form['months'])

        cursor.execute("SELECT * FROM bikes WHERE id=%s", (bike_id,))
        bike = cursor.fetchone()

        price = int(bike['price'])
        emi = int((price / months) + (price * 0.05 / months))

        cursor.execute(
            "INSERT INTO emi (bike_id, months, amount) VALUES (%s, %s, %s)",
            (bike_id, months, emi)
        )
        conn.commit()

    cursor.execute("""
        SELECT emi.*, bikes.name 
        FROM emi
        JOIN bikes ON emi.bike_id = bikes.id
    """)
    emis = cursor.fetchall()

    cursor.execute("SELECT * FROM bikes")
    bikes = cursor.fetchall()

    conn.close()

    return render_template('manage_emi.html', emis=emis, bikes=bikes)


@app.route('/delete_emi/<int:id>')
def delete_emi(id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM emi WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect('/manage_emi')

# PROFILE
@app.route('/profile')
def profile():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE id=%s", (session['user_id'],))
    user = cursor.fetchone()
    conn.close()
    return render_template('profile.html', user=user)



# LOGOUT
@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)