""" 
    Sample Model File

    A Model should be in charge of communicating with the Database. 
    Define specific model method that query the database for information.
    Then call upon these model method in your controller.

    Create a model using this template.
"""
from system.core.model import Model
import re
from datetime import datetime

class User(Model):
    def __init__(self):
        super(User, self).__init__()

    def create_user(self, info):
        EMAIL_REGEX = re.compile(r'^[a-za-z0-9\.\+_-]+@[a-za-z0-9\._-]+\.[a-za-z]*$')
        errors = []
        if not info['fname'] or not info['alias']:
            errors.append('Name fields cannot be blank')
        elif len(info['fname']) < 2 or len(info['alias']) < 2:
            errors.append('Name and Alias must be atleast 2 characters each')
        if not info['email']:
            errors.append('Email cannot be blank')
        elif not EMAIL_REGEX.match(info['email']):
            errors.append('Email format must be valid')
        if not info['pwd']:
            errors.append('Password cannot be blank')
        elif len(info['pwd']) < 8:
            errors.append('Password must be at least 8 characters long')
        elif info['pwd'] != info['c_pwd']:
            errors.append('Password and confirmation must match!')

        try:
            info['dob'] != datetime.strptime(info['dob'], "%Y-%m-%d").strftime('%Y-%m-%d')
        except ValueError:
            errors.append('Please enter the valid date format: YYYY-MM-DD')
        #Validating for errors
        if errors:
            return{'status':False, 'errors': errors}
        else:
            hashed_pw = self.bcrypt.generate_password_hash(info['pwd'])
            #Code to insert user:
            query = "INSERT INTO users (name, alias, email, pw_hash, created_at, birthdate) VALUES (:fname, :alias, :email, :pw_hash, NOW(), :dob)"
            data = { 'fname': info['fname'], 'alias': info['alias'], 'email':info['email'],'pw_hash': hashed_pw, 'dob': datetime.strptime(info['dob'], "%Y-%m-%d").strftime('%Y-%m-%d') }
            self.db.query_db(query, data)
            get_user_query = 'SELECT * FROM users ORDER BY id DESC LIMIT 1'
            users = self.db.query_db(get_user_query)
            return{'status':True, 'user':users[0]}

    def login_user(self, info):
        errors = []
        password = info['pwd']
        user_query = 'SELECT * FROM users WHERE email = :email LIMIT 1'
        user_data = {'email': info['email']}
        user = self.db.query_db(user_query, user_data)
        if user:
            print "Inside User"
            if self.bcrypt.check_password_hash(user[0]['pw_hash'],password):
                return {'status': True, 'user': user[0]}
            else:
                print "Inside else"
                errors.append('The password you entered is incorrect')
                return {'status': False, 'errors': errors}
        else:
            print "Email doesn't exist"
            errors.append('The email does not exist in the database')
            return {'status': False, 'errors': errors}

    def get_friends(self, id):
        query = 'select u.name as name,u.email as email,fu.alias as friend_alias,fu.name as friend_name,fu.id as friend_id from users u join friends f on u.id=f.user_id join users fu on fu.id=f.friend_id where u.id= :id'
        data = {'id': id}
        return self.db.query_db(query, data)

    def get_nofriends(self, id):
        query = 'select alias, id from users where id not in (select fu.id from users u join friends f on u.id=f.user_id join users fu on fu.id=f.friend_id where u.id= :id) and id != :id'
        data = {'id': id}
        return self.db.query_db(query, data)

    def get_profile(self, id):
        query = 'SELECT alias, name as user, email from users where id = :id'
        data = {'id': id}
        return self.db.query_db(query, data)

    def delete_friend(self, user_id, friend_id):
        query = 'delete from friends where (user_id= :user_id and friend_id= :friend_id) or (friend_id= :user_id and user_id= :friend_id)'
        data = {'user_id': user_id, 'friend_id': friend_id}
        return self.db.query_db(query, data)

    def add_friend(self, user_id, friend_id):
        query = 'INSERT INTO friends (user_id, friend_id) VALUES (:user_id, :friend_id)'
        data1 = {'user_id': int(user_id), 'friend_id': int(friend_id)}
        data2 = {'user_id': int(friend_id), 'friend_id': int(user_id)}
        self.db.query_db(query, data1)
        return self.db.query_db(query, data2)

    """
    Below is an example of a model method that queries the database for all users in a fictitious application
    
    Every model has access to the "self.db.query_db" method which allows you to interact with the database

    def get_users(self):
        query = "SELECT * from users"
        return self.db.query_db(query)

    def get_user(self):
        query = "SELECT * from users where id = :id"
        data = {'id': 1}
        return self.db.get_one(query, data)

    def add_message(self):
        sql = "INSERT into messages (message, created_at, users_id) values(:message, NOW(), :users_id)"
        data = {'message': 'awesome bro', 'users_id': 1}
        self.db.query_db(sql, data)
        return True
    
    def grab_messages(self):
        query = "SELECT * from messages where users_id = :user_id"
        data = {'user_id':1}
        return self.db.query_db(query, data)

    """