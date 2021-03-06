import os
from typing import List

import databases
import sqlalchemy
from fastapi import FastAPI, responses
from pydantic import BaseModel

# SQLAlchemy specific code, as with any other app
DATABASE_URL = os.environ.get('DATABASE_URL')

database = databases.Database(DATABASE_URL)

metadata = sqlalchemy.MetaData()

notes = sqlalchemy.Table(
    "notes",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True),
    sqlalchemy.Column("text", sqlalchemy.String),
    sqlalchemy.Column("completed", sqlalchemy.Boolean),
)

# https://www.postgresql.org/docs/9.1/libpq-connect.html
engine = sqlalchemy.create_engine(
    DATABASE_URL,
    connect_args={
        'sslmode': 'require',
        'sslrootcert': '/usr/local/share/ca-certificates/postgresql.crt',
    }
)
metadata.create_all(engine)


class NoteIn(BaseModel):
    text: str
    completed: bool


class Note(BaseModel):
    id: int
    text: str
    completed: bool


app = FastAPI()


@app.on_event("startup")
async def startup():
    await database.connect()


@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()


@app.get('/')
async def index():
    return responses.JSONResponse(content={'message': 'THIS'})  # .RedirectResponse(url='/docs')


@app.get("/notes/", response_model=List[Note])
async def read_notes():
    query = notes.select()
    return await database.fetch_all(query)


@app.post("/notes/", response_model=Note)
async def create_note(note: NoteIn):
    query = notes.insert().values(text=note.text, completed=note.completed)
    last_record_id = await database.execute(query)
    return {**note.dict(), "id": last_record_id}