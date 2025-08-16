from scripts.backup import make_backup

def test_root_route():
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200
    assert response.get_json() == {"message": "Hello, World!"}