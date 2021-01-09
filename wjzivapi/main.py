from fastapi import FastAPI

__doc__ = """An API by WJZIV"""

app = FastAPI()

@app.get("/")
async def root():
    return { "message": "This is an API!" }