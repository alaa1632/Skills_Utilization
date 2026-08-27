import os


class Config:
    SQLALCHEMY_DATABASE_URI = os.environ["DATABASE_URL"]
    SECRET_KEY = os.environ["SECRET_KEY"]
    JWT_SECRET_KEY = os.environ["JWT_SECRET_KEY"]
