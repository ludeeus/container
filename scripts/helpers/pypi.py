import requests


def get_version_pypi(package):
    try:
        url = f"https://pypi.python.org/pypi/{package}/json"
        response = requests.get(url).json()
        return response["info"]["version"]
    except Exception as e:
        print(f"Could not get version for {package} - {e}")
        return None
